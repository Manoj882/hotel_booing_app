// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:hotel_booking_app/screens/home_screen.dart';
// import 'package:hotel_booking_app/utils/curved_body_widget.dart';
// import 'package:hotel_booking_app/utils/size_config.dart';
// import 'package:local_auth/local_auth.dart';

// import '../constants/constant.dart';
// import '../utils/navigate.dart';

// class FingerPrintAuthScreen extends StatelessWidget {
//   const FingerPrintAuthScreen(
//       {required this.username, required this.password, Key? key})
//       : super(key: key);

//   final String username;
//   final String password;

//   @override
//   Widget build(BuildContext context) {
//     storeCredential(
//       context,
//       email: username,
//       password: password,
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Finger Print Screen"),
//       ),
//       body: GestureDetector(
//         onTap: () {
//           print("obj");
//           storeCredential(
//             context,
//             email: username,
//             password: password,
//           );
//         },
//         child: CurvedBodyWidget(
//           widget: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.fingerprint_outlined,
//                   size: SizeConfig.height * 25,
//                   color: Colors.black,
//                 ),
//                 SizedBox(
//                   height: SizeConfig.height,
//                 ),
//                 Text(
//                   "Touch the screen to add fingerprint",
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   storeCredential(
//     BuildContext context, {
//     required String email,
//     required String password,
//   }) async {
//     final localAuth = LocalAuthentication();
//     final authenticate = await localAuth.authenticate(
//       localizedReason: "Please place your fingerprint on the sensor",
//       biometricOnly: true,
//       stickyAuth: true,
      
//     );
//     if (authenticate) {
//       const flutterSecureStoraage = FlutterSecureStorage();
//       await flutterSecureStoraage.write(
//         key: SecureStorageConstants.emailKey,
//         value: email,
//       );
//       await flutterSecureStoraage.write(
//         key: SecureStorageConstants.passwordKey,
//         value: password,
//       );
//       navigate(context, HomeScreen());
//     }
//   }
// }
