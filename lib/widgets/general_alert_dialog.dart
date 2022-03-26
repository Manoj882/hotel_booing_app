import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/hotel_model.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:provider/provider.dart';

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

  Future<void> customMessageDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Sorry, room is already booked!!!",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  Future<void> customDeleteDialog(BuildContext context, Hotel hotel) async {
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Do you want to delete?",
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await Provider.of<HotelProvider>(context, listen: false)
                  .deleteHotelData(
                context,
                docId: hotel.id!,
                hotelId: hotel.id!,
              );
              Navigator.pop(context);
            },
            child: Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("No"),
          ),
        ],
      ),
    );
  }
}
