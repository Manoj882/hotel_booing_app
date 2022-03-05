import 'package:flutter/material.dart';

ThemeData ligthTheme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      
    ),
    textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontFamily: "OpenSans",
          fontWeight: FontWeight.w600,   
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color: Colors.black,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
          fontFamily: "OpenSans",
        ),
        bodyText2: TextStyle(
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          color: Colors.black,
          fontFamily: "OpenSans",
          
        ),
        subtitle2: TextStyle(
          color: Colors.black,
        ),
        caption: TextStyle(
          color: Colors.black,
          fontFamily: "OpenSans",
        ),
      ),
  );
}
