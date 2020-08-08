import 'package:flutter/material.dart';

enum AppTheme { DarkTheme, LightTheme }

final Map<AppTheme, ThemeData> appTheme = {
  AppTheme.DarkTheme: ThemeData(
      fontFamily: 'Poppins',
      accentColor: Color(0xFF03012C),
      bottomAppBarColor: Color(0xFF03012C),
      cardColor: Color(0xFF0E4B4F),
      primaryColor: Color(0xFF03012C),
      indicatorColor: Color(0xFFEA638C),
      backgroundColor: Colors.white,
      brightness: Brightness.dark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.amber,
      ),
      textTheme: TextTheme(
          headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
  AppTheme.LightTheme: ThemeData(
      accentColor: Color(0xFFA4243B),
      bottomAppBarColor: Color(0xFFA4243B),
      indicatorColor: Color(0xFF2B303A),
      canvasColor: Colors.white,
      cardColor: Color(0xFFD8C99B),
      fontFamily: 'Poppins',
      primaryColor: Color(0xFFA4243B),
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.black),
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500))),
};
