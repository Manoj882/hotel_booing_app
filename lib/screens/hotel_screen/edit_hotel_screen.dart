import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/hotel_model.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/constant.dart';
import '/utils/curved_body_widget.dart';
import '/utils/size_config.dart';
import '/utils/text_form_field.dart';
import '/utils/validation_mixin.dart';
import 'package:provider/provider.dart';
import '/widgets/general_alert_dialog.dart';

class EditHotelScreen extends StatelessWidget {
  EditHotelScreen({required this.model, required this.hotelImageUrl, Key? key})
      : super(key: key);

  final hotelNameController = TextEditingController();
  final hotelAddressController = TextEditingController();
  final hotelCityController = TextEditingController();
  final hotelDescriptionController = TextEditingController();
  final hotelAmnetiesController = TextEditingController();
  String hotelImageUrl;
  final formKey = GlobalKey<FormState>();
  final Hotel model;

  @override
  Widget build(BuildContext context) {
    
    // final future = Provider.of<HotelProvider>(context, listen: false)
    //     .fetchIndiviudalHotelData(
    //   hotelId: model.id!,
    //   hotelName: hotelNameController.text,
    //   hotelAddress: hotelAddressController.text,
    //   hotelCity: hotelCityController.text,
    // );
    hotelNameController.text = model.hotelName;
    hotelCityController.text = model.hotelCity;
    hotelAddressController.text = model.hotelAddress;
    hotelDescriptionController.text = model.hotelDescription;
    hotelAmnetiesController.text = model.hotelAmneties;
    hotelImageUrl = model.hotelImage.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Hotel"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit hotels with detail informations",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: SizeConfig.height * 2,
              ),
              Text(
                "Hotel Name",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: SizeConfig.height,
              ),
              InputTextField(
                title: "Hotel Name",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: hotelNameController,
                validate: (value) =>
                    ValidationMixin().validate(value!, "hotel name"),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: SizeConfig.height * 2,
              ),
              Text(
                "Address",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: SizeConfig.height,
              ),
              InputTextField(
                title: "Address",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: hotelAddressController,
                validate: (value) =>
                    ValidationMixin().validate(value!, "address"),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: SizeConfig.height * 2,
              ),
              Text(
                "City",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: SizeConfig.height,
              ),
              InputTextField(
                title: "City",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: hotelCityController,
                validate: (value) => ValidationMixin().validate(value!, "city"),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: SizeConfig.height * 2,
              ),
              Text(
                "Description",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: SizeConfig.height,
              ),
              InputTextField(
                title: "Description",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: hotelDescriptionController,
                validate: (value) =>
                    ValidationMixin().validate(value!, "description"),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: SizeConfig.height * 2,
              ),
              Text(
                "Amneties",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: SizeConfig.height,
              ),
              InputTextField(
                title: "Amneties",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: hotelAmnetiesController,
                validate: (value) =>
                    ValidationMixin().validate(value!, "amneties"),
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
                  onPressed: () => submit(context),
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        GeneralAlertDialog().customLoadingDialog(context);

        // final uid = Provider.of<UserProvider>(context, listen: false).user.uuid;
        final hotel = Hotel(
          hotelName: hotelNameController.text,
          hotelCity: hotelCityController.text,
          hotelAddress: hotelAddressController.text,
          hotelDescription: hotelDescriptionController.text,
          hotelAmneties: hotelAmnetiesController.text,
          hotelImage: model.hotelImage,
          id: model.id,
        );
       
        log(model.id ?? "");
        print(hotelAmnetiesController.text);

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);

        // await FirebaseHelper().addData(context, map: map, collectionId: HotelConstant.hotelCollection);
        //add hotel data from HotelProvider

        await Provider.of<HotelProvider>(context, listen: false)
            .updateHotelData(
          context,
          docId: model.id!,
          hotel: hotel,
        );
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

                            Provider.of<HotelProvider>(context, listen: false)
                                .updateHotelImage(context,
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
                            Provider.of<HotelProvider>(context, listen: false)
                                .updateHotelImage(
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
