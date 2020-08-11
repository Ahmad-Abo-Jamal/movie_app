import 'package:flutter/material.dart';

enum AppTheme { DarkTheme, LightTheme }
final List<Map<String, dynamic>> themes = [
  {
    'fontFamily': 'Poppins',
    "accentColor": Color(0xFF303A52),
    "cardColor": Color(0xFF495779),
    "primaryColor": Color(0xFF303A52),
    "indicatorColor": Color(0xFFFC85AE),
    "backgroundColor": Colors.white,
    "brightness": Brightness.dark,
    "canvasColor": Color(0xFF303A52)
  },
  {
    'fontFamily': 'Poppins',
    "buttonColor": Color(0xFF107a8b),
    "accentColor": Color(0xFF086972),
    "cardColor": Color(0xFF078F98),
    "primaryColor": Color(0xFF086972),
    "indicatorColor": Color(0xFFA7FF83),
    "backgroundColor": Colors.white,
    "brightness": Brightness.dark,
    "canvasColor": Color(0xFF086972)
  },
  {
    'fontFamily': 'Poppins',
    "accentColor": Color(0xFF85203B),
    "buttonColor": Color(0xFF492540),
    "cardColor": Color(0xFFB8264D),
    "primaryColor": Color(0xFF85203B),
    "indicatorColor": Color(0xFFFFF98C),
    "backgroundColor": Colors.white,
    "brightness": Brightness.light,
    "canvasColor": Color(0xFF85203B)
  },
  {
    'fontFamily': 'Poppins',
    "accentColor": Color(0xFF582233),
    "cardColor": Color(0xFF733142),
    "primaryColor": Color(0xFF582233),
    "indicatorColor": Color(0xFF4592AF),
    "backgroundColor": Colors.white,
    "brightness": Brightness.dark,
    "canvasColor": Color(0xFF582233)
  },
  {
    'fontFamily': 'Poppins',
    "accentColor": Color(0xFFB89803),
    "cardColor": Color(0xFFEAC100),
    "primaryColor": Color(0xFFB89803),
    "indicatorColor": Color(0xFF10316b),
    "backgroundColor": Colors.white,
    "brightness": Brightness.light,
    "canvasColor": Color(0xFFB89803)
  },
  {
    'fontFamily': 'Poppins',
    "accentColor": Color(0xFF3D6CB9),
    "cardColor": Color(0xFF4B87E9),
    "primaryColor": Color(0xFF3D6CB9),
    "indicatorColor": Color(0xFFfcb1b1),
    "backgroundColor": Colors.white,
    "brightness": Brightness.light,
    "canvasColor": Color(0xFF3D6CB9)
  },
];
ThemeData themeFromMap(Map<String, dynamic> theme) {
  return ThemeData(
    fontFamily: theme['fontFamily'],
    accentColor: theme['accentColor'],
    cardColor: theme['cardColor'],
    buttonColor: theme['buttonColor'] ?? theme['indicatorColor'],
    primaryColor: theme['primaryColor'],
    indicatorColor: theme['indicatorColor'],
    canvasColor: theme['canvasColor'],
    backgroundColor: theme['backgroundColor'],
  );
}
