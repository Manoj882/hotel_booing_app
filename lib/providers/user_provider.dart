import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  //initialize User class
  late User _user;

  setUser(Map obj) {
    _user = User.fromJson(obj);
    print(obj);
    notifyListeners();
    
  }

  User get user => _user;
  

  Map<String, dynamic> updateUser(
      {required String name, required String address, required int age}) {
    _user = User(
      uuid: _user.uuid,
      name: name,
      email: _user.email,
      image: _user.image,
      photoUrl: _user.photoUrl,
      address: address,
      age: age,
      
    );
    notifyListeners();
    return _user.toJson();
  }

  updateUserImage(String image) {
    _user.image = image;
    notifyListeners();
    // return {
    //   "image": _user.image,
    // };
  }
}
