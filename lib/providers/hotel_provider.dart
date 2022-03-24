import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/utils/firebase_helper.dart';
import 'package:provider/provider.dart';

import '../models/hotel_model.dart';

// class AddHotelProvider extends ChangeNotifier {
//   AddHotel? _addHotel;

//   AddHotel? get addHotel => _addHotel;

//   fetchHotelData(BuildContext context) async {
//     try{
//     final uuid = Provider.of<UserProvider>(context, listen: false).user.uuid;
//     final data = await FirebaseHelper().getData(
//       context,
//       collectionId: HotelConstant.hotelCollection,
//       whereId: UserConstants.userId,
//       whereValue: uuid,
//     );

//     if(data.docs.isNotEmpty){
//       _addHotel = AddHotel.fromJson(data.docs.first.data());
//     }
//     }
//     catch(ex){
//       print(ex.toString());
//     }
//   }
// }

class HotelProvider extends ChangeNotifier {
  List<Hotel> _listOfHotel = [];
  late Hotel _currentHotel;

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
      // final uuid = Provider.of<UserProvider>(context, listen: false).user.uuid;
      // final data = await FirebaseHelper().getData(
      //   context,
      //   collectionId: HotelConstant.hotelCollection,
      //   whereId: UserConstants.userId,
      //   // whereValue: uuid,
      // );

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
          print("Element id is :${element.id}");
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


//update image
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

  
}
