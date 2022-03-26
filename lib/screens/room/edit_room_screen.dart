import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/room.dart';
import 'package:provider/provider.dart';

import '../../providers/room_provider.dart';
import '../../utils/curved_body_widget.dart';
import '../../utils/size_config.dart';
import '../../utils/text_form_field.dart';
import '../../utils/validation_mixin.dart';
import '../../widgets/general_alert_dialog.dart';

class EditRoomScreen extends StatelessWidget {
  EditRoomScreen(
      {required this.model,
      required this.hotelId,
      required this.roomImageUrl,
      Key? key})
      : super(key: key);

  final roomNameController = TextEditingController();
  final roomInformationController = TextEditingController();
  final roomPriceController = TextEditingController();

  final Room model;
  String roomImageUrl;
  final String hotelId;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    roomNameController.text = model.roomName;
    roomInformationController.text = model.roomInformation;
    roomPriceController.text = model.roomPrice.toString();
    roomImageUrl = model.roomImage.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Room"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Form(
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
                  title: "Room Name",
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
                  title: "Room Information",
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
                  title: "Room Price",
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
                    onPressed:() => submit(context),
                    
                    child: const Text('Submit'),
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

        final room = Room(
          roomName: roomNameController.text,
          roomInformation: roomInformationController.text,
          roomPrice: double.parse(roomPriceController.text),
          roomImage: roomImageUrl,
          hotelId: hotelId,
          id: model.id,
          
          
        );

        

        await Provider.of<RoomProvider>(context, listen: false).updateRoomData(
          context,
          docId: model.id!,
          room: room,
        );

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      } catch (ex) {
        print(ex.toString());
      }
    }
  }
}
