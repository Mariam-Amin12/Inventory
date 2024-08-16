import 'package:flutter/material.dart';

class   TTextTheme {
  //text style for the light mode
  static TextTheme lightTheme = TextTheme(

    headlineLarge: TextStyle(color: Colors.purple, fontSize: 32, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(color: Colors.purple, fontSize: 28, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: Colors.purple, fontSize: 16),
    bodySmall: TextStyle(color: Colors.purple, fontSize: 14),
  );

  //text style for the dark mode
  static TextTheme darkTheme = TextTheme(

    headlineLarge: TextStyle(color: Colors.purple[200], fontSize: 32, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(color: Colors.purple[200], fontSize: 28, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: Colors.purple[200], fontSize: 16),
    bodySmall: TextStyle(color: Colors.purple[200], fontSize: 14),
  );
}
