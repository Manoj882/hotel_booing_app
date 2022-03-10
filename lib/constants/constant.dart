import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/size_config.dart';

final basePadding = EdgeInsets.symmetric(
    vertical: SizeConfig.height * 1,
    horizontal: SizeConfig.width * 4,
  );

class ImageConstant{
  static const googleImageUrl = "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png";
  static const facebookImageUrl = "https://pnggrid.com/wp-content/uploads/2021/05/Facebook-logo-2021-1024x1024.png";
}class HotelConstant{
  static const hotel = "hotels";
}
class LocalFileConstants{
  static const baseImagePath = "assets/images";
  static const logo = "$baseImagePath/hotel.png";
  
}
class AnimationConstants{
  static const baseAnimationPath = "assets/animations";
  static const hotel_lottie = "$baseAnimationPath/hotel-icon.json";
}

class UserConstants{
  static const userCollection = "user";
}



