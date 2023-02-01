import 'package:flutter/material.dart';

const PrimaryColorY = Color(0xFFFFD64D);
const MonLTextDark = Color(0xFF111111);
const MonLTextWhite = Color(0xFFFFFFFF);
const MonLTextGrey = Color.fromARGB(123, 65, 65, 65);

final MonLThemeData = ThemeData(
  fontFamily: "Poppins",
  primaryColor: PrimaryColorY,
);

class myTextStyleBase {
  static const headline1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: MonLTextDark,
  );
  static const cardClientText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: MonLTextWhite,
  );
  static const cardClientNameText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: MonLTextWhite,
  );
  static const checkoutInfosText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: MonLTextDark,
  );
  static const headline2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: MonLTextDark,
  );
  static const headline4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: MonLTextDark,
  );
  static const headline3 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: MonLTextDark,
  );
  static const button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: MonLTextWhite,
  );
  static const bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: MonLTextDark,
  );
  static const bodyText2 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: MonLTextGrey,
  );
  static const AdresseTextLivreur1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: MonLTextGrey,
  );
  static const buttonCard = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: MonLTextDark,
  );
}
