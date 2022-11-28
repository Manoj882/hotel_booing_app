import 'dart:collection';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/utils/firebase_helper.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geo;

import '../models/hotel_model.dart';

class HotelProvider extends ChangeNotifier {
  
  List<Hotel> _listOfHotel = [];
  late Hotel _currentHotel;

  List<Hotel> listOfSearchedHotel = [];

  //getter
  List<Hotel> get listOfHotel => _listOfHotel;
  Hotel get currentHotel => _currentHotel;
  

  //setter
  set hotelList(List<Hotel> listOfHotel) {
    _listOfHotel = listOfHotel;
    notifyListeners();
  }

  set currentHotel(Hotel hotel) {
    _currentHotel = hotel;
    _currentHotel.id = hotel.id;
    notifyListeners();
  }

  fetchHotelData(BuildContext context) async {
    try {
      final data = await FirebaseHelper().getAllData(
        context,
        collectionId: HotelConstant.hotelCollection,
      );
      // log("being called");
      if (data.docs.length != _listOfHotel.length) {
        _listOfHotel.clear();
        // data.docs.forEach((element) {
        //   _listOfHotel.add(Hotel.fromJson(element.data()));
        // });
        for (var element in data.docs) {
          // print(element.data());
          // print("Element id is :${element.id}");
          _listOfHotel.add(Hotel.fromJson(element.data(), element.id));
        }
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  //for individual hotel
  fetchIndiviudalHotelData({
    required String hotelId,
    required String hotelName,
    required String hotelAddress,
    required String hotelCity,
    required String hotelDescription,
    required String hotelAmneties,
  }) async {
    try {
      FirebaseHelper().getData(
        collectionId: HotelConstant.hotelCollection,
        whereId: HotelConstant.hotelId,
        whereValue: hotelId,
      );
    } catch (ex) {
      print(ex.toString());
    }
  }

  addHotelData(
    BuildContext context,
    String hotelName,
    String hotelCity,
    String hotelAddress,
    double latitude,
    double longitude,
    String hotelDescription,
    String hotelAmneties,
    String hotelImage,
  ) async {
    try {
      // final uuid = Provider.of<UserProvider>(context, listen: false).user.uuid;
      final hotel = Hotel(
        hotelName: hotelName,
        hotelCity: hotelCity,
        hotelAddress: hotelAddress,
        latitude: latitude,
        longitude: longitude,
        hotelDescription: hotelDescription,
        hotelAmneties: hotelAmneties,
        hotelImage: hotelImage,

        // uuid: uuid,
      );
      final map = hotel.toJson();
      final uid = await FirebaseHelper().addData(
        context,
        map: map,
        collectionId: HotelConstant.hotelCollection,
      );
      hotel.id = uid;
      listOfHotel.add(hotel);

      notifyListeners();
    } catch (ex) {
      print(ex.toString());
    }
  }

  updateHotelData(
    BuildContext context, {
    required String docId,
    required Hotel hotel,
  }) async {
    await FirebaseHelper().updateData(
      context,
      collectionId: HotelConstant.hotelCollection,
      docId: docId,
      map: hotel.toJson(),
    );

    // log("message");
    _listOfHotel.clear();
    notifyListeners();

    // final oldHotel = listOfHotel.firstWhere((element) => element.id! == docId);
    // // notifyListeners();

    // // log(oldHotel.toJson().toString());

    // final index = _listOfHotel.indexOf(oldHotel);

    // _listOfHotel.removeAt(index);
    // notifyListeners();
    // _listOfHotel.insert(index, hotel);
    // notifyListeners();
  }

//update hotel image
  updateHotelImage(
    BuildContext context, {
    required String image,
    required Hotel model,
  }) async {
    // print("object");
    final index = _listOfHotel.indexOf(model);
    _listOfHotel[index].hotelImage = image;
    notifyListeners();
    // print(image);
    await FirebaseHelper().updateData(
      context,
      collectionId: HotelConstant.hotelCollection,
      docId: model.id!,
      map: {
        "hotelImage": image,
      },
    );

    // notifyListeners();
  }

  deleteHotelData(
    BuildContext context, {
    required String docId,
    required String hotelId,
  }) async {
    try {
      FirebaseHelper().deleteData(
        context,
        collectionId: HotelConstant.hotelCollection,
        docId: docId,
      );
      notifyListeners();
    } catch (ex) {
      print(ex.toString());
    }
  }

  // List<Hotel> filterHotelList = [];

  // getHotelSearch(String search) async {
  //   if (search.isEmpty) {
  //     return [];
  //   }
  //   listOfHotel.forEach((hotel) {
  //     if (hotel.hotelName.toLowerCase().contains(search.toLowerCase()) ||
  //         hotel.hotelCity.toLowerCase().contains(search.toLowerCase())){
  //         filterHotelList.add(hotel);
  //         notifyListeners();
  //         }

  //   });
  //   return filterHotelList;

  // }

  //search hotel
  searchHotels(String hotelName) {
    final hotelList = [...listOfHotel];
    listOfSearchedHotel = hotelList
        .where((element) =>
            element.hotelName.toLowerCase().contains(hotelName.toLowerCase()))
        .toList();
  }



}
