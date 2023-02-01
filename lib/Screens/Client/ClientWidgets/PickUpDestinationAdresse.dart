import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:monlivreur/src/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';

import '../../../ConstantsWidgets/Constants.dart';
import '../../../Providers/LocationAdressProvider.dart';

class PickUpDestinationAdresse extends StatefulWidget {
  const PickUpDestinationAdresse({super.key});

  @override
  State<PickUpDestinationAdresse> createState() =>
      _PickUpDestinationAdresseState();
}

class _PickUpDestinationAdresseState extends State<PickUpDestinationAdresse> {

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
    String newDestinationLocation =
        Provider.of<LocationAdressProvider>(context, listen: false)
            .LocationDestinationAdress;
    return Scaffold(
      body: currentLocation == null ?
      Center(
        child: Image.asset(
          "assets/map-gif.gif",
          height: 200.0,
          width: 200.0,
        ),
      ) : Stack(
              children: <Widget>[
                OpenStreetMapSearchAndPick(
                    center: LatLong(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    buttonColor: PrimaryColorY,
                    buttonText: 'Choisir la destination',
                    onPicked: (pickedData) {
                      if (!mounted) {
                        return;
                      }
                      setState(() {
                        newDestinationLocation = pickedData.address;
                      });

                      Provider.of<LocationAdressProvider>(context, listen: false).DestinationAdressName(newDestinationLocation);

                      LatLng CoordSource = LatLng(pickedData.latLong.latitude, pickedData.latLong.longitude);

                      Provider.of<LocationAdressProvider>(context, listen: false).PickCoordDestinataion(CoordSource);

                      Navigator.pop(context);
                      print(pickedData.latLong.latitude);
                      print(pickedData.latLong.longitude);
                      print(newDestinationLocation);

                    })
              ],
            ),
    );
  }
}
