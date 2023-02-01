import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';
import 'package:monlivreur/src/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';

import '../../../Providers/LocationAdressProvider.dart';

// ignore: must_be_immutable
class PickUpClientAdress extends StatefulWidget {
  LatLng? value;

  @override
  State<PickUpClientAdress> createState() => _PickUpClientAdressState();
}

class _PickUpClientAdressState extends State<PickUpClientAdress> {

  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
      print(currentLocation!.latitude);
    });

    location.onLocationChanged.listen((newLoc) {
      if (!mounted) {
        return;
      }
      currentLocation = newLoc;

      setState(() {});
    });
  }

  @override
  void initState() {
    getCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String newLocation = Provider.of<LocationAdressProvider>(context,
        listen: false).LocationAdress;

    return Scaffold(
      body: currentLocation == null ?
      Center(
        child: Image.asset(
          "assets/map-gif.gif",
          height: 200.0,
          width: 200.0,
        ),
      ):
      Stack(
              children: <Widget>[
                OpenStreetMapSearchAndPick(
                    center: LatLong(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    buttonColor: PrimaryColorY,
                    buttonText: 'Choisir votre position',
                    onPicked: (pickedData) {
                      if (!mounted) {
                        return;
                      }
                      print(newLocation);
                      setState(() {
                        newLocation = pickedData.address;
                      });

                      Provider.of<LocationAdressProvider>(context, listen: false).PickUpadressName(newLocation);

                      LatLng CoordAddresse = LatLng(pickedData.latLong.latitude, pickedData.latLong.longitude);

                      Provider.of<LocationAdressProvider>(context, listen: false).PickCoordSource(CoordAddresse);

                      Navigator.pop(context);
                      print(pickedData.latLong.latitude);
                      print(pickedData.latLong.longitude);
                      print(newLocation);
                    })
              ],
            ),
    );
  }
}
