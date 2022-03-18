import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_model.dart';
import '../../providers/user_provider.dart';

import 'edit_hotel_screen.dart';

class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({required this.hotel, Key? key}) : super(key: key);

  final Hotel hotel;
  final String imageOfHotel =
      "https://www.nepal-travel-guide.com/wp-content/uploads/2020/05/image-156.png";

  @override
  Widget build(BuildContext context) {
    print(hotel.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.hotelName),
        
        actions: [
          Provider.of<UserProvider>(context).user.isAdmin
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditHotelScreen(
                              hotelImageUrl: imageOfHotel,
                              model: hotel,
                              
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Edit Hotel",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
        

      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Details",
              ),
              SizedBox(
                height: SizeConfig.height,
              ),
              buildHotelDetails(imageUrl: imageOfHotel),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHotelDetails({
    required String imageUrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.height * 1.5,
        ),
        Text(hotel.hotelAddress),
        Text(hotel.hotelCity),
      ],
    );
  }
}
