import 'package:flutter/material.dart';

class HotelModel{
  late String name;
  late String city;
  late String address;

  HotelModel.fromJson(Map obj){
    name = obj["name"];
    city = obj["city"];
    address = obj["address"];
  }
}