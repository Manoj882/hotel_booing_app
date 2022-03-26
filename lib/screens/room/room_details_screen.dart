import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/screens/book_room/book_room_screen.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:hotel_booking_app/widgets/general_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_model.dart';
import '../../models/room.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';
import 'edit_room_screen.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen(
      {required this.hotel, required this.room, required this.user, Key? key})
      : super(key: key);

  final Room room;
  final Hotel hotel;
  final User user;

  final String imageOfRoom =
      "https://upload.wikimedia.org/wikipedia/commons/3/35/Ibis_Hotels_Dresden_Single_Room_Standard_Queen_Size_Bed.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.hotelName),
        actions: [
          Provider.of<UserProvider>(context).user.isAdmin
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditRoomScreen(
                              roomImageUrl: room.roomImage!,
                              model: room,
                              hotelId: room.hotelId,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Edit Room",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [buildRoomDetails(context, roomImage: room.roomImage??imageOfRoom)],
          ),
        ),
      ),
    );
  }

  Widget buildRoomDetails(
    BuildContext context, {
    required String roomImage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          width: double.infinity,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: NetworkImage(imageUrl),
          //   ),
          // ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              SizeConfig.height * 2,
            ),
            child: room.roomImage == imageOfRoom
                ? Image.network(
                    imageOfRoom,
                    fit: BoxFit.cover,
                  )
                : Image.memory(
                    base64Decode(
                      room.roomImage!,
                    ),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        SizedBox(
          height: SizeConfig.height * 1.5,
        ),
        Text(
          room.roomName,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: SizeConfig.height,
        ),
        Text(
          "Room Informations",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: SizeConfig.height,
        ),
        Text(room.roomInformation),
        SizedBox(
          height: SizeConfig.height,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Room Price",
              style: Theme.of(context).textTheme.headline6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${room.roomPrice.toString()}",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  "/night",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black38,
                      ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.height * 2,
        ),
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.purpleAccent,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              fixedSize: MaterialStateProperty.all(
                Size(
                  MediaQuery.of(context).size.width,
                  40,
                ),
              ),
            ),
            onPressed: () {
              room.isBooked ?
              GeneralAlertDialog().customMessageDialog(context)
                                 
              : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BookRoomscreen(
                    hotel: hotel,
                    room: room,
                    user: user,
                  ),
                ),
              );
            },
            child: Text("Book Room"),
          ),
        ),
      ],
    );
  }
}
