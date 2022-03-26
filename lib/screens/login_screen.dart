import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_booking_app/models/firebase_user.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/screens/finger_print_screen.dart';
import 'package:hotel_booking_app/screens/hotel_screen/view_hotels_screen.dart.dart';
import 'package:hotel_booking_app/utils/validation_mixin.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '/utils/buttons/social_media_login_button.dart';
import '/utils/general_divider.dart';
import '/utils/size_config.dart';
import '/screens/home_screen.dart';
import '/screens/signup_screen.dart';
import '/widgets/general_alert_dialog.dart';
import '/utils/choose_account_button.dart';
import '/models/user.dart' as us;
import '/utils/submit_button.dart';
import '/utils/text_form_field.dart';
import '/constants/constant.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  // final bool canCheckBioMetric;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: basePadding,
          child: SingleChildScrollView(
            child: Padding(
              padding: basePadding,
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.height * 5,
                  ),
                  Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Color(0xff4caf50),
                        ),
                  ),

                  // SizedBox(
                  //   height: SizeConfig.height * 1.5,
                  // ),
                  Container(
                    child: Lottie.asset(
                      AnimationConstants.hotel_lottie,
                      height: 250,
                      animate: true,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height * 1.5,
                  ),

                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InputTextField(
                          title: "Email",
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          controller: emailController,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
                          validate: (value) =>
                              ValidationMixin().validateEmail(value!),
                          onFieldSubmitted: (_) {},
                        ),
                        SizedBox(
                          height: SizeConfig.height * 1.5,
                        ),
                        InputTextField(
                          title: "Password",
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: passwordController,
                          isObscure: true,
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: Colors.black,
                          ),
                          validate: (value) =>
                              ValidationMixin().validatePassword(value!),
                          onFieldSubmitted: (value) {
                            submit(context, false);
                          },
                        ),
                        // SizedBox(
                        //   height: SizeConfig.height * 1.5,
                        // ),
                        // Text(
                        //   'Forgot Password?',
                        //   style:
                        //       Theme.of(context).textTheme.bodyText1!.copyWith(
                        //             color: Color(0xff087f23),
                        //           ),
                        // ),
                        SizedBox(
                          height: SizeConfig.height * 2,
                        ),
                        GeneralSubmitButton(
                          bottonTitle: "Login",
                          onPressed: () async {
                            submit(context, false);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height * 1.5,
                  ),
                  GeneralDivider("Or"),
                  SizedBox(
                    height: SizeConfig.height * 1.5,
                  ),
                  Column(
                    children: [
                      SocialMediaLoginButton(
                        socialMediaName: "Login via Google",
                        onPressed: () async {
                          final googleSignin = GoogleSignIn();
                          final googleSignInAccountUser =
                              await googleSignin.signIn();
                          if (googleSignInAccountUser != null) {
                            final authenticateduser =
                                await googleSignInAccountUser.authentication;
                            final authCredential =
                                GoogleAuthProvider.credential(
                              idToken: authenticateduser.idToken,
                              accessToken: authenticateduser.accessToken,
                            );

                            final authResult = await FirebaseAuth.instance
                                .signInWithCredential(authCredential);

                            //added line
                            final User user = authResult.user!;

                            Provider.of<UserProvider>(context, listen: false)
                                .setUser(us.User(
                                        email: user.email,
                                        name: user.displayName,
                                        photoUrl: user.photoURL,
                                        uuid: user.uid)
                                    .toJson());

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => HomeScreen(),
                              ),
                            );
                          }
                        },
                        imageUrl: ImageConstant.googleImageUrl,
                      ),

                      SizedBox(
                        height: SizeConfig.height * 1.5,
                      ),
                      // canCheckBioMetric
                      //     ? ElevatedButton.icon(
                      //         style: ButtonStyle(),
                      //         icon: Icon(Icons.fingerprint_outlined),
                      //         label: Text("Login via Fingerprint"),
                      //         onPressed: () {
                      //           loginViaFingerPrint(context);
                      //         },
                      //       )
                      //     : SizedBox.shrink(),

                      // SizedBox(
                      //   height: SizeConfig.height * 1.5,
                      // ),
                      // SocialMediaLoginButton(
                      //   socialMediaName: "Continue with Facebook",
                      //   onPressed: () {},
                      //   imageUrl: ImageConstant.facebookImageUrl,
                      // ),
                    ],
                  ),

                  //Account link
                  GeneralChooseAccountPage(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SignUpScreen(),
                        ),
                      );
                    },
                    text: "Don't have an account?",
                    accountTitle: "Register",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  submit(
    BuildContext context,
    bool isAuthenticated,
  ) async {
    try {
      if (formKey.currentState!.validate()) {
        GeneralAlertDialog().customLoadingDialog(context);
        final email = emailController.text;
        final password = passwordController.text;

        final userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user = userCredential.user;

        if (user != null) {
          final firestore = FirebaseFirestore.instance;
          final data = await firestore
              .collection(UserConstants.userCollection)
              .where(UserConstants.userId, isEqualTo: user.uid)
              .get();
          var map = {};
          if (data.docs.isEmpty) {
            map = Firebaseuser(
              displayName: user.displayName,
              email: user.email,
              photoUrl: user.photoURL,
              uuid: user.uid,
            ).toJson();
          } else {
            map = data.docs.first.data();
          }
          // print(map);
          Provider.of<UserProvider>(context, listen: false).setUser(map);
        }
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
              // builder: (_) => ViewHotelScreen(),
            ),
          );

        // if (isAuthenticated) {
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //       builder: (_) => HomeScreen(),
        //       // builder: (_) => ViewHotelScreen(),
        //     ),
        //   );
        // } else {
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //       builder: (_) => FingerPrintAuthScreen(
        //         username: emailController.text,
        //         password: passwordController.text,
        //       ),
        //       // builder: (_) => ViewHotelScreen(),
        //     ),
        //   );
        // }
      }
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "user-not-found") {
        message = "The user does not exist.";
      } else if (e.code == "invalid-email") {
        message = "The email address is invalid.";
      } else if (e.code == "wrong-password") {
        message = "Incorrect password.";
      } else if (e.code == "too-many-requests") {
        message = "Your account is locked. Please try again later.";
      }

      Navigator.of(context).pop();
      await GeneralAlertDialog().customAlertDialog(context, message);
    } catch (ex) {
      Navigator.of(context).pop();
      await GeneralAlertDialog().customAlertDialog(context, ex.toString());
    }
  }

  void loginViaFingerPrint(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final authenticated = await localAuth.authenticate(
      localizedReason: "Enter your fingerprint to login",
      biometricOnly: true,
      stickyAuth: true,
    );
    if (authenticated) {
      final secureStorage = FlutterSecureStorage();

      final email =
          await secureStorage.read(key: SecureStorageConstants.emailKey);
      final password =
          await secureStorage.read(key: SecureStorageConstants.passwordKey);

      if (email != null) {
        emailController.text = email;
        passwordController.text = password!;
        submit(context, true);
      }
    }
  }
}
