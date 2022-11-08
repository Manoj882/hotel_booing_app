import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:hotel_booking_app/widgets/general_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../models/hotel_model.dart';
import '../providers/user_provider.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    // required this.hotelName,
    // required this.hotelAddress,
    // required this.hotelCity,
    required this.hotel,
    Key? key}) : super(key: key);

  // final String hotelName;
  // final String hotelAddress;
  // final String hotelCity;
  final Hotel hotel;

  final String imageOfHotel =
      "https://www.nepal-travel-guide.com/wp-content/uploads/2020/05/image-156.png";

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SizeConfig.height * 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            
            height: SizeConfig.height * 18,
            width: SizeConfig.height * 100,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  SizeConfig.height * 2,
                ),
                topRight: Radius.circular(
                  SizeConfig.height * 2,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  SizeConfig.height * 2,
                ),
                topRight: Radius.circular(
                  SizeConfig.height * 2,
                ),
              ),
              child: hotel.hotelImage == imageOfHotel
                  ? Image.network(
                      imageOfHotel,
                      fit: BoxFit.cover,
                    )
                  : Image.memory(
                      base64Decode(
                        hotel.hotelImage!,
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: SizeConfig.width * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.hotelName,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.place_outlined,
                      color: Colors.black38,
                    ),
                    Text(
                      hotel.hotelAddress,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: Colors.black38,
                              ),
                    ),
                    const Text(", "),
                    Text(
                      hotel.hotelCity,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: Colors.black38,
                              ),
                    ),
                    Spacer(),
                    if (Provider.of<UserProvider>(context).user.isAdmin)
                      IconButton(
                        onPressed: () async {
                          await GeneralAlertDialog()
                              .customDeleteDialog(context, hotel);
                        },
                        icon: const Icon(
                          Icons.delete_outlined,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          //delete hotel
        ],
      ),
    );
  }
}