import 'package:flutter/material.dart';

class Hotel{
  late String hotelName;
  late String hotelCity;
  late String hotelAddress;
  late String? id;
  // late String uuid;

  Hotel({
    required this.hotelName,
    required this.hotelCity,
    required this.hotelAddress,
     this.id,
   
    // required this.uuid,

  });

  Hotel.fromJson(
    Map obj,
    this.id,
  ){
    hotelName = obj["hotelName"];
    hotelCity = obj["hotelCity"];
    hotelAddress = obj["hotelAddress"];
   
    // uuid = obj["uuid"];
  }

  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
    map["hotelName"] = hotelName;
    map["hotelCity"] = hotelCity;
    map["hotelAddress"] = hotelAddress;
    
    // map["uuid"] = uuid;
    return map;
  }
}