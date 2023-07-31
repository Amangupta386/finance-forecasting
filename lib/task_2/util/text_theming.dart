
import 'package:flutter/material.dart';

import 'colors.dart';
class CustomTextStyles{
  CustomTextStyles();

  static buildTextTheme(TextTheme base) {
    return base.copyWith(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.w700,
          color:  kGrey,
          fontSize: 35.0,
        ),
        titleMedium: const TextStyle(
          fontSize: 20.0,
        ),
        titleSmall: const TextStyle(
            fontSize: 16.0,//12
            color: kLightGrey
        ),

        bodyMedium: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
        labelSmall:const TextStyle(
            fontSize: 16.0,
            color: kRed
        ),
        bodySmall: const TextStyle(
          fontSize: 16.0,
        ),
        displayMedium: const TextStyle(
            fontSize: 16.0,
            color: kOrange)

    ).apply(
      fontFamily: 'Roboto',
    );
  }


}