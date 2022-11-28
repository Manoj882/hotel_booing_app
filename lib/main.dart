import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/providers/booking_room_provider.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/screens/home_screen.dart';
import 'package:hotel_booking_app/screens/login_screen.dart';

import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:hotel_booking_app/utils/themeMode/setting_controller.dart';
import 'package:hotel_booking_app/utils/themeMode/setting_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '/Theme/theme_data.dart';
import '/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/screens/onboarding_screen.dart';
import 'providers/room_provider.dart';

bool? seenOnBoard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //to show status bar
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top]);

  //to load splash screen for the first time only
  SharedPreferences preferences = await SharedPreferences.getInstance();

  seenOnBoard = preferences.getBool("seenOnBoard") ?? false;

  // preferences.setBool("isLoggedIn", true);

  //for light or dark mode
  SettingService.sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp();
//   final localAuth = LocalAuthentication();

//  final canCheckBiometric = await localAuth.canCheckBiometrics;

  runApp(
    // MyApp(canCheckBiometric),
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // final cancheckBioMetric;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HotelProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RoomProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingRoomProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingController(),
        ),
      ],
      child: LayoutBuilder(builder: (context, boxConstraint) {
        final controller = Provider.of<SettingController>(context, listen: false,);
        SizeConfig().init(boxConstraint);
        return AnimatedBuilder(
          animation: controller,
          builder: (context, __) {
            controller.loadSetting();
            return MaterialApp(
              title: 'hotel booking app',
              theme: lightTheme(context),
              darkTheme: darkTheme(context),
              themeMode: controller.themeMode,
              debugShowCheckedModeBanner: false,
              // home: seenOnBoard == true ? LoginScreen(cancheckBioMetric) : OnBoardingScreen(),

              home:
                  (seenOnBoard == true ? LoginScreen() : const OnBoardingScreen()),

              // home: SignUpScreen(),
            );
          }
        );
      }),
    );
  }
}
