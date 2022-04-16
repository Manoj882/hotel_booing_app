

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hotel_booking_app/constants/constant.dart';

// class DirectionRepository{
//   static const String _baseUrl = 'https://maps.googleapis.com/maps/directions/json?';

//   final Dio _dio;

//   DirectionRepository({Dio? dio}) : _dio = dio ?? Dio();

//   Future<Directions> getDirections({
//     required LatLng origin,
//     required LatLng destination,

//   }) async{
//     final response = await _dio.get(
//       _baseUrl,
//       queryParameters: {
//         'origin' : '${origin.latitude},${origin.longitude}',
//         'destination' : '${destination.longitude}, ${destination.longitude}',
//         'key' : GoogleAPIKeyConstant.googleAPIKey,

//       },
//     );

//     //check whether response is successful or not
//     if(response.statusCode == 200){
//       return Directions.fromMap(response.data);
//     }
//     return null;

//   }

// }