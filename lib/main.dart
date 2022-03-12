import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/screens/login_screen.dart';

import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:provider/provider.dart';
import '/Theme/theme_data.dart';
import '/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/screens/onboarding_screen.dart';

bool? seenOnBoard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //to show status bar
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top]);

  //to load splash screen for the first time only
  SharedPreferences preferences = await SharedPreferences.getInstance();
  seenOnBoard = preferences.getBool("seenOnBoard") ?? false;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddHotelProvider(),
        ),
      ],
      child: LayoutBuilder(builder: (context, boxConstraint) {
        SizeConfig().init(boxConstraint);
        return MaterialApp(
          title: 'hotel booking app',
          theme: ligthTheme(context),
          home: seenOnBoard == true ? LoginScreen() : OnBoardingScreen(),
          // home: SignUpScreen(),
        );
      }),
    );
  }
}
