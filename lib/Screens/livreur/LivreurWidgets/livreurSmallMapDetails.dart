import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:monlivreur/Screens/Client/model/Adresse.dart';
import 'package:monlivreur/Screens/Client/model/Geopam.dart';

// ignore: must_be_immutable
class LivreurSmallMapDetails extends StatefulWidget {

  final Geopam? geopam;
  final Adresse? sourceLatLng;
  final Adresse? destinationLatLng;

  const LivreurSmallMapDetails({super.key, this.geopam,
    this.sourceLatLng, this.destinationLatLng});

  @override
  State<LivreurSmallMapDetails> createState() => _LivreurSmallMapDetailsState();
}

class _LivreurSmallMapDetailsState extends State<LivreurSmallMapDetails> {

  MapController _controller = MapController();
  late String distance;
  late String dropOffTime;
  late Map geometry;

  void initState() {
    getpolyCordiantes();
    super.initState();
  }

  List<LatLng> latLngCoordinates = [];

  getpolyCordiantes() {
    latLngCoordinates = (widget.geopam?.routes![0].geometry?.coordinates)
    !.map<LatLng>((coord) => coord).toList();
    debugPrint("Poly Cordiantes: ${latLngCoordinates}");
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


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          child: FlutterMap(
            mapController: _controller,
            options: MapOptions(
              center: getCentralLatlng((widget.geopam?.routes![0].geometry?.coordinates)
              !.map<LatLng>((coord) => coord).toList()),
              zoom: getBoundsZoomLevel(getCurrentBounds(
                  LatLng(double.parse("${widget.sourceLatLng?.laltitude}"),
                      double.parse("${widget.sourceLatLng?.longitude}")),
                  LatLng(double.parse("${widget.destinationLatLng?.laltitude}"),
                      double.parse("${widget.destinationLatLng?.longitude}"))
              ), Size(MediaQuery.of(context).size.width, 200,)) + 1.5
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    height: 100,
                    width: 100,
                    point: LatLng(double.parse("${widget.destinationLatLng?.laltitude}"),
                        double.parse("${widget.destinationLatLng?.longitude}")),
                    builder: (context) {
                      return Container(
                        child: Image.asset('assets/p1.png'),
                      );
                    },
                  ),
                  Marker(
                    height: 100,
                    width: 100,
                    point: LatLng(double.parse("${widget.sourceLatLng?.laltitude}"),
                        double.parse("${widget.sourceLatLng?.longitude}")),
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
                      color: Colors.black)
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
