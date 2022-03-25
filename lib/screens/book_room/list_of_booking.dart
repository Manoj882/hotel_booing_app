import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/providers/booking_room_provider.dart';
import 'package:hotel_booking_app/providers/room_provider.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:provider/provider.dart';

import '../../models/booking_room_model.dart';
import '../../models/room.dart';

class ListOfBookingRoom extends StatelessWidget {
  const ListOfBookingRoom({ Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).user.uuid;
    
    print("list of reservation");
    return Scaffold(
      appBar: AppBar(
        title: Text("Your All Reservation"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future:
                      Provider.of<BookingRoomProvider>(context, listen: true)
                          .fetchBookingData(
                    context,
                    userId,
                    
                  ),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final listOfBooking = Provider.of<BookingRoomProvider>(context).listOfBookingRoom;
                    return ListView.separated(
                      itemCount: listOfBooking.length,
                      itemBuilder: (context, index){
                        return bookingCard(
                          context,
                          bookingDate: listOfBooking[index].bookingDate,
                          checkIn: listOfBooking[index].checkIn,
                          checkOut: listOfBooking[index].checkOut,
                          numberOfPerson: listOfBooking[index].numberOfPerson,
                          booking: listOfBooking[index],

                        

                        );
                      },
                      separatorBuilder: (context, index){
                        return SizedBox(
                          height: SizeConfig.height * 1.5,
                        );
                      },
                      shrinkWrap: true,
                      primary: false,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Card bookingCard(
    
    BuildContext context, {
    required DateTime bookingDate,
    required DateTime checkIn,
    required DateTime checkOut,
    required int numberOfPerson,
    
    required BookingRoom booking,
  }) {
    return Card(
      
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SizeConfig.height * 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          SizeConfig.height,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookingDate.toString(),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: SizeConfig.height),
                Text(
                  checkIn.toString(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.black38,
                      ),
                ),
                   
                Text(
                  checkOut.toString(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.black38,
                      ),
                ),
                Text(
                  numberOfPerson.toString(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.black38,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
