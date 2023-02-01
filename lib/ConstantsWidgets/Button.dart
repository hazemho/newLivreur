import 'package:flutter/material.dart';
import 'package:monlivreur/ConstantsWidgets/Constants.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button(this.title, this.colorB, this.colorT, this.route, {super.key});
  String route;
  String title;
  Color colorB;
  Color colorT;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
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
