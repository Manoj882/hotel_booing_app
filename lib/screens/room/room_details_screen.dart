import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/size_config.dart';

import '../../models/hotel_model.dart';
import '../../models/room.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({required this.hotel, required this.room, Key? key})
      : super(key: key);

  final Room room;
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.hotelName),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                room.roomName,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: SizeConfig.height,
              )
            ],
          ),
        ),
      ),
    );
  }
}
