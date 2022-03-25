import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_booking_app/models/booking_room_model.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/show_date_picker.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_model.dart';
import '../../models/room.dart';
import '../../providers/booking_room_provider.dart';
import '../../providers/room_provider.dart';
import '../../utils/size_config.dart';
import '../../utils/text_form_field.dart';
import '../../utils/validation_mixin.dart';
import '../../widgets/general_alert_dialog.dart';

class BookRoomscreen extends StatelessWidget {
  BookRoomscreen({required this.hotel, required this.room,Key? key}) : super(key: key);

  final bookingDateController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final numberOfPersonController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final Hotel hotel;
  final Room room;


  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Room"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking Date",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: SizeConfig.height,
                ),
                InputTextField(
                  title: "Enter booking date",
                  readOnly: true,
                  controller: bookingDateController,
                  validate: (value) =>
                      ValidationMixin().validate(value!, "booking date"),
                  onFieldSubmitted: (_) {},
                  onTap: () async {
                    final bookingDate =
                        await ShowDatePicker().customDatePicker(context);
                    bookingDateController.text =
                        bookingDate.toString().substring(0, 10);
                  },
                ),
                SizedBox(
                  height: SizeConfig.height * 2,
                ),
                Text(
                  "Check In",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: SizeConfig.height,
                ),
                InputTextField(
                  title: "Enter check in",
                  readOnly: true,
                  controller: checkInController,
                  validate: (value) =>
                      ValidationMixin().validate(value!, "check in date"),
                  onFieldSubmitted: (_) {},
                  onTap: () async {
                    final checkin =
                        await ShowDatePicker().customDatePicker(context);
                    checkInController.text =
                        checkin.toString().substring(0, 10);
                  },
                ),
                SizedBox(
                  height: SizeConfig.height * 2,
                ),
                Text(
                  "Check Out",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: SizeConfig.height,
                ),
                InputTextField(
                  title: "Enter check out",
                  readOnly: true,
                  controller: checkOutController,
                  validate: (value) =>
                      ValidationMixin().validate(value!, "check out date"),
                  onFieldSubmitted: (_) {},
                  onTap: () async {
                    final checkOut =
                        await ShowDatePicker().customDatePicker(context);
                    checkOutController.text =
                        checkOut.toString().substring(0, 10);
                  },
                ),
                SizedBox(
                  height: SizeConfig.height * 2,
                ),
                Text(
                  "Number of Person",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: SizeConfig.height,
                ),
                InputTextField(
                  title: "Enter number of person",
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  controller: numberOfPersonController,
                  validate: (value) => ValidationMixin()
                      .validateNumber(value!, "number of person", 20),
                  onFieldSubmitted: (_) {},
                ),
                SizedBox(
                  height: SizeConfig.height * 2,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await submit(context);
                    },
                    child: Text("Booking Now"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        GeneralAlertDialog().customLoadingDialog(context);

        final userId = Provider.of<UserProvider>(context, listen: false).user.uuid;

        final map = BookingRoom(
          bookingDate: DateTime.parse(bookingDateController.text),
          checkIn: DateTime.parse(checkInController.text),
          checkOut: DateTime.parse(checkOutController.text),
          numberOfPerson: int.parse(numberOfPersonController.text),
          hotelName: hotel.hotelName,
          roomName: room.roomName,
          roomId: room.id!,
          // roomName, hoteName
          userId: userId,
          
        ).toJson();

        
        
        await Provider.of<BookingRoomProvider>(context, listen: false)
            .addBookingData(
          context,
          DateTime.parse(bookingDateController.text),
          DateTime.parse(checkInController.text),
          DateTime.parse(checkOutController.text),
          int.parse(numberOfPersonController.text),
          hotel.hotelName,
          room.roomName,
          room.id!, 
          
          userId,
          
          
        ); 

        Navigator.pop(context);
        Navigator.pop(context);

       
        
      } catch (ex) {
        print(ex.toString());
      }
    }
  }
}
