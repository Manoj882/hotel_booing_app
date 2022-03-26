class Room {
  late String roomName;
  late String hotelId;
  late String roomInformation;
  late double roomPrice;
  late String? roomImage;
  late String? id;
  bool isBooked = false;

  Room({
    required this.roomName,
    required this.roomInformation,
    required this.roomPrice,
    required this.roomImage,
    required this.hotelId,
    this.id,
    this.isBooked = false,
    
  });

  Room.fromJson(
    Map obj,
    this.id,
  ) {
    roomName = obj["roomName"];
    roomInformation = obj["roomInformation"];
    roomPrice = obj["roomPrice"];
    roomImage = obj["roomImage"];
    hotelId = obj["hotelId"];
    isBooked = obj["isBooked"];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["roomName"] = roomName;
    map["roomInformation"] = roomInformation;
    map["roomPrice"] = roomPrice;
    map["roomImage"] = roomImage;
    map["hotelId"] = hotelId;
    map["isBooked"] = isBooked;
    map["id"] = id;
    
    

    return map;
  }
}
