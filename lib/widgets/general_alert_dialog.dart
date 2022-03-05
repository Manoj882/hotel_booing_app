import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/size_config.dart';

class GeneralAlertDialog {
  customAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  customLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: SizeConfig.width * 3,
            ),
            Text("Loading"),
          ],
        ),
      ),
    );
  }
}
