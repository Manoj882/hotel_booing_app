import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';

import '../models/booking_room_model.dart';
import '../utils/firebase_helper.dart';

class BookingRoomProvider extends ChangeNotifier {
  final List<BookingRoom> _listOfBookingRoom = [];

  List<BookingRoom> get listOfBookingRoom => _listOfBookingRoom;

  fetchBookingData(BuildContext context, String roomId, String userId) async {
    try {
      if (_listOfBookingRoom.isNotEmpty) _listOfBookingRoom.clear();
      final data = await FirebaseHelper().getData(
        collectionId: BookingRoomConstants.bookingCollection,
        // whereId: RoomConstants.hotelRoomId,
        whereId: BookingRoomConstants.bookingRoomId,
        whereValue: roomId,
      );
      if (data.docs.length != _listOfBookingRoom.length) {
        _listOfBookingRoom.clear();
        for (var element in data.docs) {
          _listOfBookingRoom.add(BookingRoom.fromJson(element.data(),element.id));
        }
      }
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }

  addBookingData(
    BuildContext context,
    DateTime bookingDate,
    DateTime checkIn,
    DateTime checkOut,
    int numberOfPerson,
    String roomId,
  ) async {
    try {
      final booking = BookingRoom(
        bookingDate: bookingDate,
        checkIn: checkIn,
        checkOut: checkOut,
        numberOfPerson: numberOfPerson,
        roomId: roomId,
      );

      final map = booking.toJson();

      final bid = await FirebaseHelper().addData(
        context,
        map: map,
        collectionId: BookingRoomConstants.bookingCollection,
      );
      booking.id = bid;
      listOfBookingRoom.add(booking);
      notifyListeners();
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }
}
