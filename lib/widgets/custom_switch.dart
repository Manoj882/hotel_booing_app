import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/themeMode/setting_controller.dart';
import 'package:provider/provider.dart';

class CustomSwitch extends StatefulWidget {
  CustomSwitch({ Key? key}) : super(key: key);



  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  // bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<SettingController>(context).themeMode == ThemeMode.dark;

    return ListTile(
      leading: isDark 
      ? Icon(
        Icons.dark_mode_outlined,
        color: Colors.grey.shade500,
        
      )
      : Icon(
        Icons.light_mode_outlined,
        color: Colors.yellow.shade700,
      ),
      title: isDark 
      ? const Text(
        'Dark Mode',
      )
      : const Text(
        'Light Mode',
      ),

      trailing: Switch(
        value: isDark,
        onChanged: (value) {
          Provider.of<SettingController>(context, listen: false)
              .updateThemeMode(value);
        },
        inactiveThumbColor: Colors.yellow,
        activeColor: Colors.black,
      ),
    );
  }
}
