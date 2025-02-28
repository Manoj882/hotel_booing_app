import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '/utils/buttons/social_media_login_button.dart';
import '/utils/general_divider.dart';
import '/utils/validation_mixin.dart';
import '/utils/size_config.dart';
import '/widgets/general_alert_dialog.dart';
import '/constants/constant.dart';
import '/screens/login_screen.dart';
import '/utils/choose_account_button.dart';
import '/utils/submit_button.dart';
import '/utils/text_form_field.dart';
import 'home_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: basePadding,
          child: Padding(
            padding: basePadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.height * 5,
                  ),
                  Container(
                    child: Image.asset(LocalFileConstants.logo),
                  ),
                  SizedBox(
                    height: SizeConfig.height * 2,
                  ),
                  Text(
                    'Create Your Account',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4caf50),
                        ),
                  ),
                  SizedBox(
                    height: SizeConfig.height * 2,
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
                          ),
                          validate: (value) => ValidationMixin().validateEmail(value!),
                          onFieldSubmitted: (_){},
                        ),
                        SizedBox(
                          height: SizeConfig.height * 2.5,
                        ),
                        InputTextField(
                          title: "Password",
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: passwordController,
                          isObscure: true,
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                          ),
                          validate: (value) => ValidationMixin().validatePassword(value!),
                          onFieldSubmitted: (_){},
                        ),
                        SizedBox(
                          height: SizeConfig.height * 2.5,
                        ),
                        InputTextField(
                          title: "Confirm Password",
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: confirmPasswordController,
                          isObscure: true,
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                          ),
                          validate: (value) => ValidationMixin().validatePassword(
                            passwordController.text,
                            isConfirmed: true,
                            confrimValue: value!,
                          ),
                          onFieldSubmitted: (value){
                            submit(context);
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.height * 2,
                        ),
                        GeneralSubmitButton(
                          onPressed: () async {
                            submit(context);  
                          },
                          bottonTitle: "Register",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height * 1.5,
                  ),
                  GeneralDivider("Or sign in with"),
                  SizedBox(
                    height: SizeConfig.height * 1.5,
                  ),
                  SocialMediaLoginButton(
                    socialMediaName: "Google",
                    onPressed: () async {
                      final googleSignin = GoogleSignIn();
                      final user = await googleSignin.signIn();
                      if (user != null) {
                        final authenticateduser =
                            await user.authentication;
                        final authProvider =
                            GoogleAuthProvider.credential(
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
                  
                 
                  SizedBox(
                    height: SizeConfig.height * 1.5,
                  ),
                  GeneralChooseAccountPage(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                      );
                      
                    },
                    text: "Already have an account?",
                    accountTitle: "Login",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  submit(context) async{
     try {
    if (formKey.currentState!.validate()) {
        GeneralAlertDialog().customLoadingDialog(context);
        final email = emailController.text;
        final password = passwordController.text;
        
       
          final user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: email,
            password: password,
            
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) => LoginScreen(),
          //   ),
          // );
        }
        } on FirebaseAuthException catch (e) {
          String message = "";
          if (e.code == "email-already-in-use") {
            message = "The email address is already used.";
          } else if (e.code == "invalid-email") {
            message = "The email address is invalid.";
          } else if (e.code == "weak-password") {
            message =
                "Your password is too weak, try adding alphaneumeric characters.";
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
}
