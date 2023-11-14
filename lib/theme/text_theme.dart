import 'package:ddofinance/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/theme/color_constants.dart';


///Custom text styles that are used across the application.
class CustomTextStyles {
  CustomTextStyles();

  static buildTextTheme(TextTheme base) {
    return base
        .copyWith(
          titleLarge: TextStyle(
            fontSize: FontSizes.s28,
            fontWeight: FontWeight.w700,
            color: kGreyDark,
          ),
          titleMedium: TextStyle(
            fontSize: FontSizes.s20,
          ),
          bodyMedium: TextStyle(
            fontSize: FontSizes.s16,
          ),
          bodySmall: TextStyle(
            fontSize: FontSizes.s14,
          ),
        )
        .apply(
          fontFamily: 'Roboto',
        );
  }
}
