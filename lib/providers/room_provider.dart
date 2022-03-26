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
      if (_listOfRoom.isNotEmpty) _listOfRoom.clear();
      final data = await FirebaseHelper().getData(
        collectionId: RoomConstants.roomCollection,
        whereId: RoomConstants.hotelRoomId,
        whereValue: hotelId,
      );
      if (data.docs.length != _listOfRoom.length) {
        _listOfRoom.clear();
        for (var element in data.docs) {
          _listOfRoom.add(Room.fromJson(element.data(), element.id));
        }
      }
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }

  addRoomData(
    BuildContext context,
    String name,
    String information,
    double price,
    String roomImage,
    String hotelId,
    
  ) async {
    try {
      final room = Room(
        roomName: name,
        roomInformation: information,
        roomPrice: price,
        hotelId: hotelId,
        roomImage: roomImage,
      );

      final map = room.toJson();

      final uid = await FirebaseHelper().addData(
        context,
        map: map,
        collectionId: RoomConstants.roomCollection,
      );
      room.id =uid;
      listOfRoom.add(room);
      notifyListeners();
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }

  updateRoomStatus(BuildContext context,{required String roomId, required bool isBooked,} ) async{
    try {
      final map = {
        "isBooked": isBooked,
      };

      await FirebaseHelper().updateData(
        context,
        map: map,
        collectionId: RoomConstants.roomCollection,
        docId: roomId,
      );

      final room = _listOfRoom.firstWhere((element) => element.id == roomId);
      room.isBooked = isBooked;
      notifyListeners();
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }


  //update room data
  updateRoomData(
    BuildContext context, {
    required String docId,
    required Room room,
    
  
  }) async {
    await FirebaseHelper().updateData(
      context,
      collectionId: RoomConstants.roomCollection,
      docId: docId,
       map: room.toJson(),

    );
    

    
    _listOfRoom.clear();
    notifyListeners();
    

    
  }

  updateRoomImage(
    BuildContext context, {
    required String image,
    required Room model,
  }) async {
    // print("object");
    final index = _listOfRoom.indexOf(model);
    _listOfRoom[index].roomImage = image;
    notifyListeners();
    // print(image);
    await FirebaseHelper().updateData(
      context,
      collectionId: RoomConstants.roomCollection,
      docId: model.id!,
      map: {
        "roomImage": image,
      },
    );

    // notifyListeners();
  }




}
