import 'package:flutter/material.dart';
import 'package:hotel_booking_app/providers/booking_room_provider.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:provider/provider.dart';

import '../../models/booking_room_model.dart';
import '../../utils/size_config.dart';

class AllUserBookedRoom extends StatelessWidget {
  const AllUserBookedRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Booking Rooms",
        ),
      ),
      body: CurvedBodyWidget(
        widget: FutureBuilder(
          future: Provider.of<BookingRoomProvider>(context, listen: true).fetchAllBookingData(context),

          builder: (context,snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
              
            }
            final listOfBooking = Provider.of<BookingRoomProvider>(context).listOfBookingRoom;

            return listOfBooking.isEmpty
            ? Center(
              child: Text("Any room is not booking"),
            )
            : SingleChildScrollView(
              child: Column(
                children: [

                  ListView.separated(
                      itemCount: listOfBooking.length,
                      itemBuilder: (context, index) {
                        return bookingCard(
                          context,
                          bookingDate: listOfBooking[index].bookingDate,
                          checkIn: listOfBooking[index].checkIn,
                          checkOut: listOfBooking[index].checkOut,
                          numberOfPerson: listOfBooking[index].numberOfPerson,
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
                    ),
                  
                ],
              ),
            );
          }
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
          onPressed: () async{
            await Provider.of<BookingRoomProvider>(context, listen: false).deleteBooking(
              context,
              docId: booking.id!,
              roomId: booking.roomId,
            );
          },
          icon: Icon(
            Icons.delete_outlined,
          ),
        ),
      ),
    );

    
  }
}
