import 'package:flutter/material.dart';

class AppThemeMode {


  static const primaryColor = Color(0xFFFFD64D);
  static const secondaryColor = Color(0xFFEFEFEF);

  static const containerBackground = Color(0xFFFFFFFF);
  static const containerFieldColor = Color(0xFFEFEFEF);

  static const textColorWhite = Color(0xFFFFFFFF);
  static const textColorBlack = Color(0xFF000000);
  static const textColorError = Color(0xFFFF0000);


  static get errorStyle {
    return const TextStyle(fontSize: 8,
        color: AppThemeMode.textColorError);
  }

  static get outlineInputBorderSearch {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(color: AppThemeMode.containerFieldColor, width: 0.5),
    );
  }

  static get outlineInputBorderGrey {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppThemeMode.containerFieldColor, width: 0.5),
    );
  }

  static get outlineInputBorder {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: AppThemeMode.textColorWhite, width: 0.5),
    );
  }


  static get outlineInputBorderNone {
    return OutlineInputBorder(borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12.0));
  }

}
