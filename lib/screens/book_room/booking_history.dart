import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:provider/provider.dart';

import '../../models/booking_room_model.dart';
import '../../providers/booking_room_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/size_config.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).user.uuid;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Booking Histories"),
      ),
      body: CurvedBodyWidget(
        widget: FutureBuilder(
          future: Provider.of<BookingRoomProvider>(context, listen: true)
              .fetchBookingData(
            context,
            userId,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final listOfBooking =
                Provider.of<BookingRoomProvider>(context).listOfBookingRoom;
            return listOfBooking.isEmpty
                ? Center(
                    child: Text("You don't have any room booking history"),
                  )
                : ListView.separated(
                    itemCount: listOfBooking.length,
                    itemBuilder: (context, index) {
                      return historyCard(
                        context,
                        
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

  Widget historyCard(
    BuildContext context, {
    
    required BookingRoom booking,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 2,
          vertical: SizeConfig.height,
        ),
        child: Table(
          children: [
            buildTableRow(
              context,
              title: "Username",
              value: booking.userEmail,
            ),
            buildTableSpacer(context),
            buildTableRow(
              context,
              title: "Hotel Name",
              value: booking.hotelName,
            ),
            buildTableSpacer(context),
            buildTableRow(
              context,
              title: "Room Name",
              value: booking.roomName,
            ),
            buildTableSpacer(context),
            buildTableRow(
              context,
              title: "Booking Date",
              value: booking.bookingDate.toString(),
            ),
            buildTableSpacer(context),
            buildTableRow(
              context,
              title: "Check In",
              value: booking.checkIn.toString(),
            ),
            buildTableSpacer(context),
            buildTableRow(
              context,
              title: "Check Out",
              value: booking.checkOut.toString(),
            ),
            buildTableSpacer(context),
            buildTableRow(
              context,
              title: "Number of Person",
              value: booking.numberOfPerson.toString(),
            ),
          ],
        ),
      ),
    );
  }

  TableRow buildTableRow(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return TableRow(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: SizeConfig.width * 3.5,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: SizeConfig.width * 3.5,
              ),
        ),
      ],
    );
  }
  TableRow buildTableSpacer(BuildContext context) {
    return TableRow(children: [
      SizedBox(
        height: SizeConfig.height,
      ),
      SizedBox(
        height: SizeConfig.height,
      ),
    ]);
  }
}
