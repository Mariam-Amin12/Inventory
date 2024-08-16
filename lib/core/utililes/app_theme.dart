import 'package:curt_task/core/utililes/app_text.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  //for the light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme:TTextTheme.lightTheme
  );

  //for the dark theme
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
    textTheme:TTextTheme.darkTheme
  );
}
