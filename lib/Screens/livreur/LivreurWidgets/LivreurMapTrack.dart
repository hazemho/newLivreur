import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:monlivreur/Providers/LivreurProviders/LivreurColisProvider.dart';
import 'package:monlivreur/Providers/PolylineLivreur.dart';
import 'package:monlivreur/Screens/Client/model/ColisData.dart';
import 'package:monlivreur/Screens/livreur/LivreurWidgets/PopUpLivreur.dart';
import 'package:provider/provider.dart';

import '../../../ConstantsWidgets/Constants.dart';

class LivreurMapTrack extends StatefulWidget {

  final bool isEnable;
  final ColisData? colisData;
  const LivreurMapTrack(this.colisData, {this.isEnable = false});

  @override
  State<LivreurMapTrack> createState() => _LivreurMapTrackState();
}

class _LivreurMapTrackState extends State<LivreurMapTrack> {


  MapController controller = MapController();

  @override
  void initState() {

    getCurrentLocation();
    getpolyCordiantes();

    if(widget.isEnable){
      Provider.of<LivreurColisProvider>(context,
          listen: false).setEtatColis(widget.colisData?.id, 3);
    }
    super.initState();
  }

  List<LatLng> latLngCoordinates = [];

  List<LatLng> latLngCoordinates2 = [];

  getpolyCordiantes() {
    latLngCoordinates = (widget.colisData?.geopam?.routes![0].geometry?.coordinates)
        !.map<LatLng>((coord) => coord).toList();
  }

  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) => currentLocation = location);

    LatLng sourceLatLng = LatLng(
      double.parse("${widget.colisData?.infopersonEnv?.adresse?.laltitude}"),
      double.parse("${widget.colisData?.infopersonEnv?.adresse?.longitude}"),
    );


    location.onLocationChanged.listen((newLoc) async {
      if (!mounted) {
        return;
      }
      currentLocation = newLoc;

      Map modifiedResponse2 = await getDirectionsAPIResponse(
          LatLng(newLoc.latitude!, newLoc.longitude!), sourceLatLng);

      latLngCoordinates2 = (modifiedResponse2['geometry']['coordinates'])
          .map<LatLng>((coord) => LatLng(coord[1], coord[0])).toList();

      setState(() {});
    });
  }

  LatLng getCentralLatlng(List<LatLng> geoCoordinates) {
    if (geoCoordinates.length == 1) {
      return geoCoordinates.first;
    }

    double x = 0;
    double y = 0;
    double z = 0;

    for (var geoCoordinate in geoCoordinates) {
      var latitude = geoCoordinate.latitude * pi / 180;
      var longitude = geoCoordinate.longitude * pi / 180;

      x += cos(latitude) * cos(longitude);
      y += cos(latitude) * sin(longitude);
      z += sin(latitude);
    }

    var total = geoCoordinates.length;

    x = x / total;
    y = y / total;
    z = z / total;

    var centralLongitude = atan2(y, x);
    var centralSquareRoot = sqrt(x * x + y * y);
    var centralLatitude = atan2(z, centralSquareRoot);

    return LatLng(centralLatitude * 180 / pi, centralLongitude * 180 / pi);
  }

  double getBoundsZoomLevel(LatLngBounds bounds, Size mapDimensions) {
    var worldDimension = Size(1024, 1024);

    double latRad(lat) {
      var sinValue = sin(lat * pi / 180);
      var radX2 = log((1 + sinValue) / (1 - sinValue)) / 2;
      return max(min(radX2, pi), -pi) / 2;
    }

    double zoom(mapPx, worldPx, fraction) {
      return (log(mapPx / worldPx / fraction) / ln2).floorToDouble();
    }

    var ne = bounds.northEast;
    var sw = bounds.southWest;

    var latFraction = (latRad(ne?.latitude) - latRad(sw?.latitude)) / pi;

    var lngDiff = ne!.longitude - sw!.longitude;
    var lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;

    var latZoom = zoom(mapDimensions.height, worldDimension.height, latFraction);
    var lngZoom = zoom(mapDimensions.width, worldDimension.width, lngFraction);

    if (latZoom < 0) return lngZoom;
    if (lngZoom < 0) return latZoom;

    return min(latZoom, lngZoom);
  }

  LatLngBounds getCurrentBounds(LatLng position1, LatLng position2) {
    LatLngBounds bounds;
    try {
      bounds = LatLngBounds(position1, position2,);
    } catch (_) {
      bounds = LatLngBounds(position2, position1,);
    }
    return bounds;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColorY,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text('Course en cours'),
      ),
      body: currentLocation == null
          ? Center(
              child: Image.asset(
                "assets/map-gif.gif",
                height: 200.0,
                width: 200.0,
              ),
            )
          : Stack(children: [
              FlutterMap(
                mapController: controller,
                options: MapOptions(
                  // center: LatLng(
                  //   currentLocation!.latitude!,
                  //   currentLocation!.longitude!,
                  // ),
                    center: getCentralLatlng(
                        (widget.colisData?.geopam?.routes![0].geometry?.coordinates)
                        !.map<LatLng>((coord) => coord).toList()),
                    zoom: getBoundsZoomLevel(getCurrentBounds(
                        LatLng(
                          double.parse("${widget.colisData?.infopersonEnv?.adresse?.laltitude}"),
                          double.parse("${widget.colisData?.infopersonEnv?.adresse?.longitude}"),
                        ),
                        LatLng(
                          double.parse("${widget.colisData?.infopersonRec?.adresse?.laltitude}"),
                          double.parse("${widget.colisData?.infopersonRec?.adresse?.longitude}"),
                        )
                    ), Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height,)) + 2
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        height: 20,
                        width: 20,
                        point: LatLng(
                            currentLocation!.latitude!,
                            currentLocation!.longitude!,
                        ),
                        builder: (context) {
                          return Container(
                            child: Image.asset('assets/p3.png'),
                          );
                        },
                      ),
                      Marker(
                        height: 100,
                        width: 100,
                        point: LatLng(
                          double.parse("${widget.colisData?.infopersonRec?.adresse?.laltitude}"),
                          double.parse("${widget.colisData?.infopersonRec?.adresse?.longitude}"),
                        ),
                        builder: (context) {
                          return Container(
                            child: Image.asset('assets/p1.png'),
                          );
                        },
                      ),
                      Marker(
                        height: 100,
                        width: 100,
                        point: LatLng(
                          double.parse("${widget.colisData?.infopersonEnv?.adresse?.laltitude}"),
                          double.parse("${widget.colisData?.infopersonEnv?.adresse?.longitude}"),
                        ),
                        builder: (context) {
                          return Container(
                            child: Image.asset('assets/p2.png'),
                          );
                        },
                      ),
                    ],
                  ),
                  PolylineLayer(
                    polylineCulling: false,
                    polylines: [
                      Polyline(
                          points: latLngCoordinates,
                          strokeWidth: 5,
                          color: Colors.black),
                      Polyline(
                          points: latLngCoordinates2,
                          strokeWidth: 5,
                          color: Colors.indigo)
                    ],
                  )
                ],
              ),
              Visibility(visible: false,
                child: Positioned(
                  bottom: 240,
                  right: 5,
                  child: FloatingActionButton(
                    heroTag: 'btn1',
                    backgroundColor: PrimaryColorY,
                    onPressed: () {
                      showDialog(context: context,
                          builder: (BuildContext context) {
                            return LivreurPopUp(
                                'assets/problemColis.png',
                                'Signaler un incident', 0, 0,
                                    () => Navigator.pop(context));
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: PrimaryColorY,
                      radius: 35,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.asset('assets/problemColis.png')),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 180,
                right: 5,
                child: FloatingActionButton(
                  heroTag: 'btn2',
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    showDialog(context: context,
                        builder: (BuildContext context) {
                          return LivreurPopUp('assets/Recuperation.png', 'Colis récupéré',
                              widget.colisData?.id, 3, () {});
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 35,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset('assets/Recuperation.png')),
                  ),
                ),
              ),
              Positioned(
                bottom: 120,
                right: 5,
                child: FloatingActionButton(
                  heroTag: 'btn6',
                  backgroundColor: Colors.green,
                  onPressed: () {
                    showDialog(context: context,
                        builder: (BuildContext context) {
                          return LivreurPopUp('assets/colisdone.png', 'colis livré',
                            widget.colisData?.id, 5, () => Navigator.pop(context));
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 35,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset('assets/colisdone.png')),
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                right: 5,
                child: FloatingActionButton(
                  heroTag: 'btn5',
                  backgroundColor: Colors.red,
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context) =>
                            LivreurPopUp('assets/annuleCourse.png', 'Annuler la course',
                              widget.colisData?.id, 4, () => Navigator.pop(context)));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 35,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset('assets/annuleCourse.png')),
                  ),
                ),
              ),
            ]),
    );
  }
}
