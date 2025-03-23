import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/color_scheme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    fontFamily: GoogleFonts.nunitoSans().fontFamily,
    textTheme: appTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    fontFamily: GoogleFonts.nunitoSans().fontFamily,
    textTheme: appTextTheme,
  );
}

TextTheme appTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 96,
    height: 1.2,
    fontWeight: FontWeight.w400,
  ),
  displayMedium: TextStyle(
    fontSize: 60,
    height: 1.2,
    fontWeight: FontWeight.w400,
  ),
  displaySmall: TextStyle(
    fontSize: 48,
    height: 1.2,
    fontWeight: FontWeight.w400,
  ),
  headlineLarge: TextStyle(
    fontSize: 40,
    height: 1.2,
    fontWeight: FontWeight.w800,
  ),
  headlineMedium: TextStyle(
    fontSize: 34,
    height: 1.2,
    fontWeight: FontWeight.w500,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w700,
  ),
  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.5,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    height: 1.2,
    fontWeight: FontWeight.w700,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.2,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.2,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.2,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.2,
  ),
  labelMedium: TextStyle(
    fontSize: 11,
    height: 1.2,
    fontWeight: FontWeight.w400,
  ),
  labelSmall: TextStyle(
    fontSize: 10,
    height: 1.5,
    fontWeight: FontWeight.w400,
  ),
);
