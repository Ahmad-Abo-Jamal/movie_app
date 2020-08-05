import 'package:flutter/material.dart';

enum AppTheme { DarkTheme, LightTheme }

final Map<AppTheme, ThemeData> appTheme = {
  AppTheme.DarkTheme: ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.amber,
      ),
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.amber,
              fontSize: 20.0,
              fontWeight: FontWeight.bold))),
  AppTheme.LightTheme: ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Colors.teal,
      backgroundColor: Colors.tealAccent,
      brightness: Brightness.light,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.black),
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500))),
};
