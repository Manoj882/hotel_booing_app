

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService{
  static SharedPreferences? sharedPreferences;

  ThemeMode themeMode(){
    final isDarkMode = sharedPreferences!.getBool(ThemeConstants.darkMode) ?? false;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
    // return ThemeMode.system;

  }

  updateThemeMode(bool isDarkMode) async{
    await sharedPreferences!.setBool(ThemeConstants.darkMode, isDarkMode);
  }
}