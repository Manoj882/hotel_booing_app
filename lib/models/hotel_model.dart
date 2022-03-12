import 'package:flutter/material.dart';

class AddHotel{
  late String hotelName;
  late String hotelCity;
  late String hotelAddress;
  late String uuid;

  AddHotel({
    required this.hotelName,
    required this.hotelCity,
    required this.hotelAddress,
    required this.uuid,

  });

  AddHotel.fromJson(Map obj){
    hotelName = obj["hotelName"];
    hotelCity = obj["hotelCity"];
    hotelAddress = obj["hotelAddress"];
    uuid = obj["uuid"];
  }

  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
    map["hotelName"] = hotelName;
    map["hotelCity"] = hotelCity;
    map["hotelAddress"] = hotelAddress;
    map["uuid"] = uuid;
    return map;
  }
}