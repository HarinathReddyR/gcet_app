import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

const appBackgroundColor = Color(0XFFD2FFF4);

class Themes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white10,
    scaffoldBackgroundColor: appBackgroundColor,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
    colorScheme:
        ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 64, 147, 193)),
    primarySwatch: Colors.blue,
    useMaterial3: true,
    fontFamily: "Montserrat",
  );
}

TextStyle get SubHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
}

TextStyle get HeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}
