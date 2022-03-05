import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_booking_app/utils/buttons/social_media_login_button.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import '/screens/add_hotel_screen.dart';
import '/screens/home_screen.dart';
import '/screens/signup_screen.dart';
import '/utils/lottie_animation.dart';
import '/widgets/general_alert_dialog.dart';
import '/utils/choose_account_button.dart';
import '/utils/submit_button.dart';
import '/utils/text_form_field.dart';
import '/constants/constant.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: basePadding,
          child: SingleChildScrollView(
            child: Padding(
              padding: basePadding,
              child: Column(
                children: [
                  const LottieAnimation("Welcome Back"),
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
                          validate: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter your username";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.height * 1.5,
                        ),
                        InputTextField(
                          title: "Password",
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: passwordController,
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: Colors.black,
                          ),
                          validate: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.height * 1.5,
                        ),
                        Text(
                          'Forgot Password?',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.blue,
                                  ),
                        ),
                        SizedBox(
                          height: SizeConfig.height * 1.5,
                        ),
                        GeneralSubmitButton(
                          bottonTitle: "Login",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              GeneralAlertDialog().customLoadingDialog(context);
                              final email = emailController.text;
                              final password = passwordController.text;

                              try {
                                final user = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => AddHotel(),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                String message = "";
                                if (e.code == "user-not-found") {
                                  message = "The user does not exist";
                                } else if (e.code == "invalid-email") {
                                  message = "The email address is invalid";
                                } else if (e.code == "wrong-password") {
                                  message = "Incorrect password";
                                } else if (e.code == "too-many-requests") {
                                  message =
                                      "Your account is locked. Please try again later";
                                }

                                Navigator.of(context).pop();
                                GeneralAlertDialog()
                                    .customAlertDialog(context, message);
                              } catch (ex) {
                                Navigator.of(context).pop();
                                GeneralAlertDialog()
                                    .customAlertDialog(context, ex.toString());
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height * 1.5,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          endIndent: 5,
                        ),
                      ),
                      Text("OR"),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          indent: 5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.height * 1.5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SocialMediaLogin(
                          socialMediaName: "Google",
                          onPressed: () async {
                            final googleSignin = GoogleSignIn();
                            final user = await googleSignin.signIn();
                            if (user != null) {
                              final authenticateduser = await user.authentication;
                              final authProvider = GoogleAuthProvider.credential(
                                idToken: authenticateduser.idToken,
                                accessToken: authenticateduser.accessToken,
                              );

                              await FirebaseAuth.instance
                                  .signInWithCredential(authProvider);

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => HomeScreen(),
                                ),
                              );
                            }
                          },
                          imageUrl: ImageConstant.googleImageUrl,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.width * 5,
                      ),
                      Expanded(
                        child: SocialMediaLogin(
                          socialMediaName: "Facebook",
                          onPressed: () {},
                          imageUrl: ImageConstant.facebookImageUrl,
                        ),
                      ),
                    ],
                  ),
 

                  // FlatButton(
                  //   color: Colors.grey.shade300,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius:
                  //         BorderRadius.circular(SizeConfig.height * 2),
                  //   ),
                  //   onPressed: () async {
                  //     final googleSignin = GoogleSignIn();
                  //     final user = await googleSignin.signIn();
                  //     if (user != null) {
                  //       final authenticateduser = await user.authentication;
                  //       final authProvider = GoogleAuthProvider.credential(
                  //         idToken: authenticateduser.idToken,
                  //         accessToken: authenticateduser.accessToken,
                  //       );

                  //       await FirebaseAuth.instance
                  //           .signInWithCredential(authProvider);

                  //       Navigator.of(context).pushReplacement(
                  //         MaterialPageRoute(
                  //           builder: (_) => HomeScreen(),
                  //         ),
                  //       );
                  //     }
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.all(5.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         CachedNetworkImage(
                  //           imageUrl: ImageConstant.googleImageUrl,
                  //           width: SizeConfig.width * 10,
                  //           placeholder: (_, __) => SizedBox(
                  //             width: SizeConfig.width * 10,
                  //             height: SizeConfig.height * 5,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: SizeConfig.width * 3,
                  //         ),
                  //         Text(
                  //           "Login with Google",
                  //           style: Theme.of(context).textTheme.headline6,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

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
}
