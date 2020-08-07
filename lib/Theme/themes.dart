import 'package:flutter/material.dart';

enum AppTheme { DarkTheme, LightTheme }

final Map<AppTheme, ThemeData> appTheme = {
  AppTheme.DarkTheme: ThemeData(
      fontFamily: 'Poppins',
      bottomAppBarColor: Colors.black,
      primaryColor: Colors.black,
      tabBarTheme: TabBarTheme(
          indicator:
              BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey)),
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
      bottomAppBarColor: Colors.black,
      fontFamily: 'Poppins',
      primaryColor: Colors.teal,
      tabBarTheme: TabBarTheme(
          indicator:
              BoxDecoration(shape: BoxShape.rectangle, color: Colors.blueGrey)),
      backgroundColor: Colors.blueGrey,
      brightness: Brightness.light,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.black),
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500))),
};
