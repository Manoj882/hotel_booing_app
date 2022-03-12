import 'package:flutter/cupertino.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/utils/firebase_helper.dart';
import 'package:provider/provider.dart';

import '../models/hotel_model.dart';

class AddHotelProvider extends ChangeNotifier {
  AddHotel? _addHotel;

  AddHotel? get addHotel => _addHotel;

  fetchHotelData(BuildContext context) async {
    try{
    final uuid = Provider.of<UserProvider>(context, listen: false).user.uuid;
    final data = await FirebaseHelper().getData(
      context,
      collectionId: HotelConstant.hotelCollection,
      whereId: UserConstants.userId,
      whereValue: uuid,
    );
    
    if(data.docs.isNotEmpty){
      _addHotel = AddHotel.fromJson(data.docs.first.data());
    }
    }
    catch(ex){
      print(ex.toString());
    }
  }
}
