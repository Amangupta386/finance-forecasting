import 'package:flutter/material.dart';
import 'package:ddofinance/theme/text_theme.dart';
import 'color_constants.dart';

///Theming that is being used across the application.
class AppTheme {
  AppTheme();

  static ThemeData buildTheme() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
        seedColor: kViolet,
        primary: kViolet,
        secondary: kWhite,
        onPrimary: kGrey,
        onSecondary: kGreyDark,
        onSecondaryContainer: kLightGreen,
        secondaryContainer: kDarkGreen,
        outline: kOrange,
        outlineVariant: kLightViolet,
        onBackground: kBlack,
        background: kGreyShade,
        surface: kGreen,
        onTertiary: kSeaBlue,
        inverseSurface: kWhiteShade,
        onInverseSurface: kWhiteContainer,
        onSurface: kGreyShade1,
        onTertiaryContainer: kRed,
      onSurfaceVariant: kTransparent,
      tertiary: kOffWhite,
      surfaceVariant: kBackgroundShade

    );
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: kDarkGrey,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: kWhite,
      appBarTheme: const AppBarTheme(backgroundColor: kWhite, elevation: 0),
      highlightColor: kSeaBlue,
      iconTheme: const IconThemeData(color: kRed, size: 20),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
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
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: kViolet,
            foregroundColor: kWhite,
          )),
    );
  }
}
