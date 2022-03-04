import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_booking_app/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/screens/login_screen.dart';
import '/screens/onboarding_screen.dart';

bool? seenOnBoard;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //to show status bar
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top]);
  //to load splash screen for the first time only
  SharedPreferences preferences = await SharedPreferences.getInstance();
  seenOnBoard = preferences.getBool("seenOnNoard") ?? false;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: seenOnBoard == true ? SignUpScreen(): OnBoardingScreen(),
    );
  }
}



