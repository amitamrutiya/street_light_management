import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:street_light_management/constant/app_colors.dart';

class TAppsTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(
          headline2:
              GoogleFonts.montserrat(color: AppColors.primaryTextColor)));

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
}
