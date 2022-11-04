import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/firebase_helper.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:hotel_booking_app/utils/text_form_field.dart';
import 'package:hotel_booking_app/utils/validation_mixin.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
        ),
      ),
      body: CurvedBodyWidget(
        widget: Column(
          children: [
            Text(
              'You can always reset your account by entering your email',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: SizeConfig.height * 2,
            ),
            Form(
              key: formKey,
              child: InputTextField(
                title: 'Email',
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validate: (value) => ValidationMixin().validateEmail(value!),
                onFieldSubmitted: (_) {},
              ),
            ),
            SizedBox(
              height: SizeConfig.height * 2,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(
                          email: emailController.text.trim(),
                        )
                        .whenComplete(
                          () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Email has been sent',
                              ),
                            ),
                          ),
                        );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No user found with this emial'),
                        ),
                      );
                    }
                  }
                }
              },
              child: Center(
                child: Text(
                  'Send Email',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
