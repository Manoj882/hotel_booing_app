import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/models/room.dart';
import 'package:hotel_booking_app/providers/room_provider.dart';
import 'package:hotel_booking_app/screens/room/add_room_screen.dart';
import 'package:hotel_booking_app/screens/room/room_details_screen.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/navigate.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:hotel_booking_app/widgets/general_alert_dialog.dart';

import 'package:provider/provider.dart';

import '../../models/hotel_model.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';

class ChooseRoomScreen extends StatelessWidget {
  const ChooseRoomScreen(
      {required this.hotelId,
      required this.hotel,
      required this.user,
      Key? key})
      : super(key: key);

  final String hotelId;
  final Hotel hotel;
  final User user;

  final String imageOfRoom =
      "https://upload.wikimedia.org/wikipedia/commons/3/35/Ibis_Hotels_Dresden_Single_Room_Standard_Queen_Size_Bed.png";

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<RoomProvider>(context, listen: true)
        .fetchRoomData(context, hotelId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a room for booking"),
        actions: [
          Provider.of<UserProvider>(context).user.isAdmin
              ? IconButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddRoomScreen(
                          hotelId: hotelId,
                          roomImageUrl: imageOfRoom,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add_outlined,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
      body: CurvedBodyWidget(
        widget: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final listOfRoom =
                  Provider.of<RoomProvider>(context, listen: false).listOfRoom;
              print("room is $listOfRoom");

              return listOfRoom.isEmpty
                  ? Center(
                      child: Text(
                        "Any room is not available",
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Room",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height: SizeConfig.height * 2,
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: listOfRoom.length,
                            itemBuilder: (context, index) {
                              print(listOfRoom[index].roomName);
                              return InkWell(
                                onTap: () {
                                  
                                  navigate(
                                          context,
                                          RoomDetailsScreen(
                                            room: listOfRoom[index],
                                            hotel: hotel,
                                            user: user,
                                          ),
                                        );
                                },
                                child: roomCard(
                                  context,
                                  roomName: listOfRoom[index].roomName,
                                  roomInformation:
                                      listOfRoom[index].roomInformation,
                                  roomPrice:
                                      listOfRoom[index].roomPrice.toString(),
                                  room: listOfRoom[index],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: SizeConfig.height * 1.5,
                              );
                            },
                            shrinkWrap: true,
                            primary: false,
                          ),
                        ],
                      ),
                    );
            }),
      ),
    );
  }

  roomCard(
    BuildContext context, {
    required String roomName,
    required String roomInformation,
    required String roomPrice,
    required Room room,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SizeConfig.height * 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeConfig.height * 15,
            width: double.infinity,

          
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                SizeConfig.height * 2,
              ),
              child: room.roomImage == imageOfRoom
              ?Image.network(
                imageOfRoom,
              fit: BoxFit.cover,)
              :Image.memory(
                      base64Decode(
                        room.roomImage!,

                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          
          Padding(
            padding: basePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomName,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: SizeConfig.height),
                Row(
                  children: [
                    Text(
                      "\$${roomPrice} /night",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
