class Room {
  late String roomName;
  late String hotelId;
  late String roomInformation;
  late double roomPrice;
  late String? id;
  bool isBooked = false;

  Room({
    required this.roomName,
    required this.roomInformation,
    required this.roomPrice,
    required this.hotelId,
    this.isBooked = false,
  });

  Room.fromJson(
    Map obj,
    this.id,
  ) {
    roomName = obj["roomName"];
    roomInformation = obj["roomInformation"];
    roomPrice = obj["roomPrice"];
    hotelId = obj["hotelId"];
    isBooked = obj["isBooked"];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["roomName"] = roomName;
    map["roomInformation"] = roomInformation;
    map["roomPrice"] = roomPrice;
    map["hotelId"] = hotelId;
    map["isBooked"] = isBooked;
    

    return map;
  }
}
