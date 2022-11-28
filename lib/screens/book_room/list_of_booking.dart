import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  const ListOfBookingRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).user.uuid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your All Reservation"),
      ),
      body: CurvedBodyWidget(
        widget: FutureBuilder(
            future:
                Provider.of<BookingRoomProvider>(context, listen: true)
                    .fetchBookingData(
              context,
              userId,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final listOfBooking =
                  Provider.of<BookingRoomProvider>(context)
                      .listOfBookingRoom;

              return listOfBooking.isEmpty
                  ? const Center(
                      child: Text(
                        "You don't book any room",
                      ),
                    )
                  : ListView.separated(
                      itemCount: listOfBooking.length,
                      itemBuilder: (context, index) {
                        return bookingCard(
                          context,
                          bookingDate: listOfBooking[index].bookingDate,
                          checkIn: listOfBooking[index].checkIn,
                          checkOut: listOfBooking[index].checkOut,
                          numberOfPerson:
                              listOfBooking[index].numberOfPerson,
                          booking: listOfBooking[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: SizeConfig.height * 1.5,
                        );
                      },
                      shrinkWrap: true,
                      primary: false,
                    );
            },
            ),
      ),
    );
  }

  bookingCard(
    BuildContext context, {
    required DateTime bookingDate,
    required DateTime checkIn,
    required DateTime checkOut,
    required int numberOfPerson,
    required BookingRoom booking,
  }) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(
          booking.hotelName,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(booking.roomName),
        trailing: IconButton(
          onPressed: () async {
            await Provider.of<BookingRoomProvider>(context, listen: false)
                .deleteBooking(
              context,
              docId: booking.id!,
              roomId: booking.roomId,
            );
          },
          icon: const Icon(
            Icons.delete_outlined,
          ),
        ),
      ),
    );
  }
}
