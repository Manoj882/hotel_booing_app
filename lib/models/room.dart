class Room {
  late String roomName;
  late String hotelId;


  Room({
    required this.roomName,
    required this.hotelId,
  
  });

  Room.fromJson(Map obj) {
    roomName = obj["roomName"];
    hotelId = obj["hotelId"];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["roomName"] = roomName;
    map["hotelId"] = hotelId;
  
    return map;
  }
}
 