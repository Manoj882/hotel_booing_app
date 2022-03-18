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

  List<Hotel> get listOfHotel => _listOfHotel;

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

      if (data.docs.length != _listOfHotel.length) {
        _listOfHotel.clear();
        // data.docs.forEach((element) {
        //   _listOfHotel.add(Hotel.fromJson(element.data()));
        // });
        for (var element in data.docs) {
          // print(element.data());
          // print(element.id);
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
  }) async {
    try{
    FirebaseHelper().getData(
      collectionId: HotelConstant.hotelCollection,
      whereId: HotelConstant.hotelId,
      whereValue: hotelId,
    );
    } catch(ex){
      print(ex.toString());
    }
  }

  addHotelData(
    BuildContext context,
    String hotelName,
    String hotelCity,
    String hotelAddress,
  ) async {
    try {
      // final uuid = Provider.of<UserProvider>(context, listen: false).user.uuid;
      final hotel = Hotel(
        hotelName: hotelName,
        hotelCity: hotelCity,
        hotelAddress: hotelAddress,
        // uuid: uuid,
      );
      final map = hotel.toJson();
      await FirebaseHelper().addData(
        context,
        map: map,
        collectionId: HotelConstant.hotelCollection,
      );
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
    final oldHotel = listOfHotel.firstWhere((element) => element.id! ==docId);
    
    final index = _listOfHotel.indexOf(oldHotel);
    _listOfHotel.removeAt(index);
    _listOfHotel.insert(index, hotel);
    notifyListeners();
  }
}
