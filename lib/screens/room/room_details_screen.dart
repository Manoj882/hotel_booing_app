import 'package:flutter/material.dart';
import 'package:hotel_booking_app/screens/book_room/book_room_screen.dart';
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
              ),
              Text(
                room.roomInformation,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: SizeConfig.height,
              ),
              Text(
                room.roomPrice.toString(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: SizeConfig.height,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookRoomscreen(hotel: hotel,room: room,),
                      ),
                    );
                  },
                  child: Text("Book Room"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
