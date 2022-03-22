import 'package:flutter/material.dart';

class Hotel{
  late String hotelName;
  late String hotelCity;
  late String hotelAddress;
  late String hotelDescription;
  late String hotelAmneties;
  late String? hotelImage;
  late String? id;
  // late String uuid;

  Hotel({
    required this.hotelName,
    required this.hotelCity,
    required this.hotelAddress,
    required this.hotelDescription,
    required this.hotelAmneties,
    required this.hotelImage,
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
    hotelDescription = obj["hotelDescription"];
    hotelAmneties = obj["hotelAmneties"];
    hotelImage = obj["hotelImage"];
   
    // uuid = obj["uuid"];
  }

  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
    map["hotelName"] = hotelName;
    map["hotelCity"] = hotelCity;
    map["hotelAddress"] = hotelAddress;
    map["hotelDescription"] = hotelDescription;
    map["hotelAmneties"] = hotelAmneties;
    map["hotelImage"] = hotelImage;
    map["id"] = id;
    
    // map["uuid"] = uuid;
    return map;
  }
}