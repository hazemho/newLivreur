import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';


import 'package:location/location.dart';

import 'package:monlivreur/ConstantsWidgets/Constants.dart';


// ignore: must_be_immutable
class ButtonFunction extends StatelessWidget {
  ButtonFunction(
    this.title,
    this.colorB,
    this.colorT,
    this.position,
    this.currentLocation,
  );
  LatLng? position;
  String title;
  Color colorB;
  Color colorT;
  LocationData? currentLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // if (position != null) {
            //   Provider.of<LocationAdressProvider>(context, listen: false)
            //       .adressName(position!.latitude, position!.longitude);
            // } else {
            //   Provider.of<LocationAdressProvider>(context, listen: false)
            //       .adressName(
            //           currentLocation!.latitude, currentLocation!.longitude);
            // }

            // Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorB,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              // side: BorderSide(width: 2, color: Colors.white),
            ),
            minimumSize: Size.fromHeight(28),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              title,
              style: myTextStyleBase.button,
            ),
          ),
        ),
      ),
    );
  }
}
