import 'package:flutter/material.dart';
import '/utils/size_config.dart';

ThemeData ligthTheme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.blue,
    // isLightMode ? Color(0xFFF7F7F7)( : Color(0xFF1A1A1A);
    // scaffoldBackgroundColor: Color(0xffFFF3E9),
    scaffoldBackgroundColor: Color(0xFFF7F7F7),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFF7F7F7),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: SizeConfig.width * 4,
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
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xffe8f5e9),
      filled: true ,
      contentPadding: EdgeInsets.symmetric(
        vertical: SizeConfig.height * 2,
        horizontal: SizeConfig.width * 2,
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            SizeConfig.height * 2,
          ),
        ),
    ),
  );
}
