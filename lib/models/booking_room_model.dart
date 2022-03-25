import 'package:cloud_firestore/cloud_firestore.dart';

class BookingRoom {
  DateTime bookingDate = DateTime.now();
  DateTime checkIn = DateTime.now();
  DateTime checkOut = DateTime.now();
  late int numberOfPerson;
  late String roomId;
  late String userId;
  late String? id;
  late String hotelName;
  late String roomName;
  late String userEmail;


  BookingRoom({
    required this.bookingDate,
    required this.checkIn,
    required this.checkOut,
    required this.numberOfPerson,
    required this.roomId,
    required this.hotelName,
    required this.roomName,
    required this.userEmail,
    required this.userId,
  });

  BookingRoom.fromJson(
    Map obj,
    this.id,
  ) {
    bookingDate = (obj["bookingDate"]as Timestamp).toDate();
    checkIn = (obj["checkIn"] as Timestamp).toDate();
    checkOut = (obj["checkOut"]as Timestamp).toDate();
    numberOfPerson = obj["numberOfPerson"];
    roomId = obj["roomId"];
    
    hotelName = obj["hotelName"];
    roomName = obj["roomName"];
    userEmail = obj["userEmail"];
    userId = obj["userId"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["bookingDate"] = bookingDate;
    map["checkIn"] = checkIn;
    map["checkOut"] = checkOut;
    map["numberOfPerson"] = numberOfPerson;
    map["roomId"] = roomId;
    map["hotelName"] = hotelName;
    map["roomName"] = roomName;
    map["userEmail"] = userEmail;

    map["userId"] = userId;
    return map;
  }
}
