import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/providers/room_provider.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/booking_room_model.dart';
import '../models/hotel_model.dart';
import '../models/room.dart';
import '../utils/firebase_helper.dart';

class BookingRoomProvider extends ChangeNotifier {
  final List<BookingRoom> _listOfBookingRoom = [];

  List<BookingRoom> get listOfBookingRoom => _listOfBookingRoom;

  fetchBookingData(BuildContext context, String userId) async {
    // final userId = Provider.of<UserProvider>(context).user.uuid;
    try {
      if (_listOfBookingRoom.isNotEmpty) _listOfBookingRoom.clear();
      final data = await FirebaseHelper().getData(
        collectionId: BookingRoomConstants.bookingCollection,
        whereId: BookingRoomConstants.userId,
        whereValue: userId,
      );
      if (data.docs.length != _listOfBookingRoom.length) {
        _listOfBookingRoom.clear();
        for (var element in data.docs) {
          _listOfBookingRoom
              .add(BookingRoom.fromJson(element.data(), element.id));
        }
      }
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }




  //fetch all booking data
  fetchAllBookingData(BuildContext context) async {
    try {
      
      final data = await FirebaseHelper().getAllData(
        context,
        collectionId: BookingRoomConstants.bookingCollection,
      );
      // log("being called");
      if (data.docs.length != _listOfBookingRoom.length) {
        _listOfBookingRoom.clear();
        
        for (var element in data.docs) {
          
          _listOfBookingRoom.add(BookingRoom.fromJson(element.data(), element.id));
        }
      }
    } catch (ex) {
      print(ex.toString());
    }
  }


  addBookingData(
    BuildContext context,
    DateTime bookingDate,
    DateTime checkIn,
    DateTime checkOut,
    int numberOfPerson,
    String hotelName,
    String roomName,
    String userEmail,
    String roomId,
    String userId,
  ) async {
    try {
      final booking = BookingRoom(
        bookingDate: bookingDate,
        checkIn: checkIn,
        checkOut: checkOut,
        numberOfPerson: numberOfPerson,
        hotelName: hotelName,
        roomName: roomName,
        userEmail: userEmail,
        roomId: roomId,
        userId: userId,
      );

      // room Id, roomName, Hotel Name

      final map = booking.toJson();

      final bid = await FirebaseHelper().addData(
        context,
        map: map,
        collectionId: BookingRoomConstants.bookingCollection,
      );

      // TODO: Uncomment and add room Id

      await Provider.of<RoomProvider>(context, listen: false)
          .updateRoomStatus(context, roomId: roomId, isBooked: true);

      booking.id = bid;
      listOfBookingRoom.add(booking);
      notifyListeners();
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }
  
  deleteBooking(
    BuildContext context, {
    required String docId,
    required String roomId,
  }) async {
    try{
    FirebaseHelper().deleteData(
      context,
      collectionId: BookingRoomConstants.bookingCollection,
      docId: docId,
    );

    await Provider.of<RoomProvider>(context, listen: false)
        .updateRoomStatus(context, roomId: roomId, isBooked: false);
    notifyListeners();
  }
  catch(ex){
    print(ex.toString());
  }
  } 
  
}
