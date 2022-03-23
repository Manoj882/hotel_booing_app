import 'package:flutter/material.dart';
import 'package:hotel_booking_app/providers/room_provider.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/widgets/general_alert_dialog.dart';
import 'package:hotel_booking_app/widgets/general_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ChooseRoomScreen extends StatelessWidget {
  const ChooseRoomScreen({required this.hotelId,Key? key}) : super(key: key);

  final String hotelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a room for booking"),
        actions: [
          IconButton(
            onPressed: () async {
              final roomName =
                  await GeneralButtomSheet().customBottomSheet(context);
              // print(roomName);
              if (roomName != null) {
                try{
                  GeneralAlertDialog().customLoadingDialog(context);
                await Provider.of<RoomProvider>(context, listen: false)
                    .addRoomData(context, roomName, hotelId);
                    Navigator.pop(context);
                    Navigator.pop(context);
                } catch (ex){
                  Navigator.pop(context);
                  GeneralAlertDialog().customAlertDialog(context, ex.toString());
                }
              }
            },
            icon: Icon(
              Icons.add_outlined,
            ),
          ),
        ],
      ),
      body: CurvedBodyWidget(
        widget: FutureBuilder(
            future: Provider.of<RoomProvider>(context).fetchRoomData(context, hotelId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Room"),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
