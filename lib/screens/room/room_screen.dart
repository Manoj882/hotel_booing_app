import 'package:flutter/material.dart';
import 'package:hotel_booking_app/providers/room_provider.dart';
import 'package:hotel_booking_app/screens/room/add_room_screen.dart';
import 'package:hotel_booking_app/screens/room/room_details_screen.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/navigate.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:hotel_booking_app/widgets/general_alert_dialog.dart';


import 'package:provider/provider.dart';

import '../../models/hotel_model.dart';
import '../../providers/user_provider.dart';


class ChooseRoomScreen extends StatelessWidget {
  const ChooseRoomScreen({required this.hotelId, required this.hotel, Key? key})
      : super(key: key);

  final String hotelId;
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<RoomProvider>(context, listen: true)
        .fetchRoomData(context, hotelId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a room for booking"),
        actions: [
          Provider.of<UserProvider>(context).user.isAdmin ?
          IconButton(
            onPressed: () async { 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddRoomScreen(hotelId: hotelId),
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
                            itemCount: listOfRoom.length,
                            
                            itemBuilder: (context, index) {
                              print(listOfRoom[index].roomName);
                              return InkWell(
                                
                                onTap: () {
                                  print("Booking status: ${listOfRoom[index].isBooked}");
                                  listOfRoom[index].isBooked ?
                                  GeneralAlertDialog().customMessageDialog(context)

                                  : navigate(
                                  context,
                                  RoomDetailsScreen(
                                    room: listOfRoom[index],
                                    hotel: hotel,
                                  ),
                                  );
                                
                                
                            },
                                child: Container(
                                  height: SizeConfig.height * 12,
                                  width: double.infinity,
                                  child: Card(
                                    elevation: 3,
                                    child: Center(
                                      child: Text(listOfRoom[index].roomName),
                                    ),
                                  ),
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
}
