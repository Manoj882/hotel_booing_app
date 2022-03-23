import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/models/hotel_model.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
import 'package:provider/provider.dart';

import '../models/room.dart';
import '../utils/firebase_helper.dart';

class RoomProvider extends ChangeNotifier {
  List<Room> _listOfRoom = [];

  List<Room> get listOfRoom => _listOfRoom;

  fetchRoomData(BuildContext context, String hotelId) async {
    try {


      final data = await FirebaseHelper().getData(
        collectionId: RoomConstants.roomCollection,
        whereId: HotelConstant.hotelId,
        whereValue: hotelId,
      );
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }

  addRoomData(BuildContext context, String name, String hotelId,) async {
    try {
 
        final map = Room(
        roomName: name,
        hotelId: hotelId,
        ).toJson();

      print(map);

      await FirebaseHelper().addData(
        context,
        map: map,
        collectionId: RoomConstants.roomCollection,
      );
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }
}
