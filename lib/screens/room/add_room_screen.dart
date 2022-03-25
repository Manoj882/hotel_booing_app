import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/room.dart';
import 'package:provider/provider.dart';

import '../../providers/room_provider.dart';
import '../../utils/curved_body_widget.dart';
import '../../utils/size_config.dart';
import '../../utils/text_form_field.dart';
import '../../utils/validation_mixin.dart';
import '../../widgets/general_alert_dialog.dart';

class AddRoomScreen extends StatelessWidget {
  AddRoomScreen({required this.hotelId, required this.roomImageUrl, Key? key})
      : super(key: key);

  final roomNameController = TextEditingController();
  final roomInformationController = TextEditingController();
  final roomPriceController = TextEditingController();

  final String hotelId;
  final String roomImageUrl;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<RoomProvider>(context, listen: false)
        .fetchRoomData(context, hotelId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Hotel"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Room Name",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: SizeConfig.height,
                      ),
                      InputTextField(
                        title: "Enter room name",
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: roomNameController,
                        validate: (value) =>
                            ValidationMixin().validate(value!, "room name"),
                        onFieldSubmitted: (_) {},
                      ),
                      SizedBox(
                        height: SizeConfig.height * 2,
                      ),
                      Text(
                        "Room Information",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: SizeConfig.height,
                      ),
                      InputTextField(
                        title: "Enter room information",
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: roomInformationController,
                        validate: (value) =>
                            ValidationMixin().validate(value!, "room name"),
                        onFieldSubmitted: (_) {},
                      ),
                      SizedBox(
                        height: SizeConfig.height * 2,
                      ),
                      Text(
                        "Room Price",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: SizeConfig.height,
                      ),
                      InputTextField(
                        title: "Enter room price",
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        controller: roomPriceController,
                        validate: (value) => ValidationMixin()
                            .validateNumber(value!, "room price", 100000),
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
                          child: const Text('Add'),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        GeneralAlertDialog().customLoadingDialog(context);

        final map = Room(
          roomName: roomNameController.text,
          roomInformation: roomInformationController.text,
          roomPrice: double.parse(roomPriceController.text),
          hotelId: hotelId,
          roomImage: roomImageUrl,
        ).toJson();

        await Provider.of<RoomProvider>(context, listen: false).addRoomData(
          context,
          roomNameController.text,
          roomInformationController.text,
          double.parse(roomPriceController.text),
          roomImageUrl,
          hotelId,
          
        );

        Navigator.pop(context);
        Navigator.pop(context);
      } catch (ex) {
        print(ex.toString());
      }
    }
  }
}
