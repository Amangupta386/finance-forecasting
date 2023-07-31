
import 'package:finance_forecasting/task_2/util/text_theming.dart';
import 'package:flutter/material.dart';

import 'colors.dart';


class AppTheme {
  AppTheme();

  static ThemeData buildTheme() {
    final ColorScheme colorScheme =
    ColorScheme.fromSeed(seedColor: kViolet, secondary: kWhite);
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: kDarkGrey,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: kWhite,
      appBarTheme: const AppBarTheme(backgroundColor: kWhite, elevation: 0),
      highlightColor: kSeaBlue,
      iconTheme: const IconThemeData(color: kGrey, size: 18),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(18.0),
              foregroundColor: kWhite,
              backgroundColor: kViolet,
              textStyle: const TextStyle(fontSize: 12))),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightGrey, // Light grey border color
            width: 1.0,
          ),

          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),

      textTheme: CustomTextStyles.buildTextTheme(base.textTheme),
    );
  }
}