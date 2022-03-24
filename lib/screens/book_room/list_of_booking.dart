import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';

class ListOfBookingRoom extends StatelessWidget {
  const ListOfBookingRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your All Reservation"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "My Reservation",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
