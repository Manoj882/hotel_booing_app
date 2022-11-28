
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/themeMode/setting_service.dart';

class SettingController with ChangeNotifier{
  SettingService settingService = SettingService();

  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  loadSetting(){
    _themeMode = settingService.themeMode();
  }

  updateThemeMode(bool isDarkMode) async{
    if(isDarkMode){
      if(_themeMode == ThemeMode.dark){
        return;
      }
    }
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await settingService.updateThemeMode(isDarkMode);
  }

}