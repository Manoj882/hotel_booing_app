import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/models/hotel_model.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
import 'package:provider/provider.dart';

import '../models/room.dart';
import '../utils/firebase_helper.dart';

class RoomProvider extends ChangeNotifier {
  final List<Room> _listOfRoom = [];

  List<Room> get listOfRoom => _listOfRoom;

  fetchRoomData(BuildContext context, String hotelId) async {
    try { 

      if(_listOfRoom.isNotEmpty) _listOfRoom.clear();
      final data = await FirebaseHelper().getData(
        collectionId: RoomConstants.roomCollection,
        whereId: RoomConstants.hotelRoomId,
        whereValue: hotelId,
      );
      if(data.docs.length != _listOfRoom.length){
        _listOfRoom.clear();
        for(var element in data.docs){          
          _listOfRoom.add(Room.fromJson(element.data()));          
        }
      }


    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }

  addRoomData(BuildContext context, String name, String hotelId,) async {
    try {
 
        final room = Room(
        roomName: name,
        hotelId: hotelId,
        );

        final map = room.toJson();  

      await FirebaseHelper().addData(
        context,
        map: map,
        collectionId: RoomConstants.roomCollection,
      );
      
      
      listOfRoom.add(room);
      notifyListeners();
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }
}
