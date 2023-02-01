import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonReplaced extends StatelessWidget {
  ButtonReplaced(this.title, this.colorB, this.colorT, this.route, {super.key});
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
            Navigator.pushReplacementNamed(context, route);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorB,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(width: 2, color: Colors.white),
            ),
            minimumSize: Size.fromHeight(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: TextStyle(
                  color: colorT, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
