import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

// Color(0XFFD2FFF4) previous color
const appBackgroundColor = Colors.white;

class Themes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
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

Widget heading(String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    ),
  );
}

Widget subheading(String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
      color: Colors.black.withOpacity(0.9),
    ),
  );
}

Widget Description(String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.grey[800],
    ),
  );
}
