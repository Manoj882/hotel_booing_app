import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/lottie_animation.dart';
import 'package:hotel_booking_app/widgets/general_alert_dialog.dart';
import '/constants/constant.dart';
import '/screens/login_screen.dart';
import '/utils/background_image.dart';
import '/utils/choose_account_button.dart';
import '/utils/submit_button.dart';
import '/utils/text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

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
                  const LottieAnimation("Create an Account"),
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
                              return "Please enter your email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
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
                        const SizedBox(
                          height: 15,
                        ),
                        GeneralSubmitButton(
                          onPressed: () async{
                            if (formKey.currentState!.validate()) {
                              GeneralAlertDialog().customLoadingDialog(context);
                              final email = emailController.text;
                              final password = passwordController.text;

                              try{
                              final user = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                            on FirebaseAuthException catch(e){
                              String message = "";
                              if(e.code == "email-already-in-use"){
                                
                                message = "The email address is already used";
                                }
                                else if(e.code == "invalid-email"){
                                  message = "The email address is invalid";
                                }
                                else if(e.code == "weak-password"){
                                  message = "Your password is too weak, try adding alphaneumeric characters";
                                }

                                Navigator.of(context).pop();             
                                GeneralAlertDialog().customAlertDialog(context, message);

                            }
                            catch(ex){
                              Navigator.of(context).pop();
                              GeneralAlertDialog().customAlertDialog(context, ex.toString());
                              // print("The error is: ${ex.toString()}");
                            }

                            }
                          },
                          bottonTitle: "Register",
                        ),
                      ],
                    ),
                  ),
                  GeneralChooseAccountPage(
                    onPressed: () {
                      Navigator.of(context).push(
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
}
