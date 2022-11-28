import 'package:flutter/material.dart';
import '/utils/size_config.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primaryColor: const Color(0xff4caf50),
    // isLightMode ? Color(0xFFF7F7F7)( : Color(0xFF1A1A1A);
    // scaffoldBackgroundColor: Color(0xffFFF3E9),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xff4caf50),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: SizeConfig.width * 4,
      ),
    ),
    textTheme: const TextTheme(
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
      fillColor: const Color(0xffe8f5e9),
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
      iconColor: const Color(0xff4caf50),
      prefixIconColor: const Color(0xff4caf50),
    ),

  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.black,
    // isLightMode ? Color(0xFFF7F7F7)( : Color(0xFF1A1A1A);
    // scaffoldBackgroundColor: Color(0xffFFF3E9),
    scaffoldBackgroundColor: Colors.black38,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: SizeConfig.width * 4,
      ),
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontFamily: "OpenSans",
        fontWeight: FontWeight.w600,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontFamily: "OpenSans",
      ),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        color: Color(0xff4caf50),
        fontFamily: "OpenSans",
      ),
      subtitle2: TextStyle(
        color: Colors.white,
      ),
      caption: TextStyle(
        color: Colors.white,
        fontFamily: "OpenSans",
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xffe8f5e9),
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
      iconColor: const Color(0xff4caf50),
      prefixIconColor: const Color(0xff4caf50),
    ),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),

  );
}
