import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/room.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';
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
                  onPressed: () async {
                    await showBottomSheet(context);
                  },
                  child: Text("Upload Image"),
                ),
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
          roomImage: model.roomImage,
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

  Future<void> showBottomSheet(BuildContext context) async {
    final imagePicker = ImagePicker();

    await showModalBottomSheet(
        context: context,
        builder: (_) => Padding(
              padding: basePadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Choose a source",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: SizeConfig.height * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildPhotoChooseOption(
                        context,
                        function: () async {
                          final xFile = await imagePicker.pickImage(
                            source: ImageSource.camera,
                            maxWidth: 480,
                            maxHeight: 640,
                          );
                          if (xFile != null) {
                            final uint8List = await xFile.readAsBytes();

                            Provider.of<RoomProvider>(context, listen: false)
                                .updateRoomImage(context,
                                    image: base64Encode(uint8List),
                                    model: model);
                          }
                        },
                        iconData: Icons.photo_camera_outlined,
                        label: "Camera",
                      ),
                      buildPhotoChooseOption(
                        context,
                        function: () async {
                          final xFile = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (xFile != null) {
                            final uint8List = await xFile.readAsBytes();
                            // print(model.id ?? "Xaina");
                            Provider.of<RoomProvider>(context, listen: false)
                                .updateRoomImage(
                              context,
                              image: base64Encode(uint8List),
                              model: model,
                            );
                          }
                        },
                        iconData: Icons.collections_outlined,
                        label: "Gallery",
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  Column buildPhotoChooseOption(
    BuildContext context, {
    required Function function,
    required IconData iconData,
    required String label,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: () => function(),
          color: Theme.of(context).primaryColor,
          icon: Icon(iconData),
          iconSize: SizeConfig.height * 5,
        ),
        Text(
          label,
        ),
      ],
    );
  }
}
