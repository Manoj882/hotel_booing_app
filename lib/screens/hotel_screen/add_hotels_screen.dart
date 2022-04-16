

import 'dart:convert';

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

class AddHotelsScreen extends StatelessWidget {
  AddHotelsScreen({required this.hotelImageUrl,  Key? key}) : super(key: key);

  final hotelNameController = TextEditingController();
  final hotelAddressController = TextEditingController();
  final hotelCityController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final hotelDescriptionController = TextEditingController();
  final hotelAmnetiesController = TextEditingController();
  final String hotelImageUrl;
  
 
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    final future = Provider.of<HotelProvider>(context, listen: false)
        .fetchHotelData(context);
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
                // final hotelProvider =
                //     Provider.of<HotelProvider>(context, listen: false)
                //         .addHotel;
                // if (hotelProvider != null) {
                //   hotelNameController.text = hotelProvider.hotelName;
                //   hotelCityController.text = hotelProvider.hotelCity;
                //   hotelAddressController.text = hotelProvider.hotelAddress;
                // }
                return Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add hotels with detail informations",
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
                        textInputAction: TextInputAction.next,
                        controller: hotelCityController,
                        validate: (value) =>
                            ValidationMixin().validate(value!, "city"),
                        onFieldSubmitted: (_) {},
                      ),
                      SizedBox(
                        height: SizeConfig.height * 2,
                      ),
                      Text(
                        "Latitude",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: SizeConfig.height,
                      ),
                      InputTextField(
                        title: "Latitude",
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: latitudeController,
                        validate: (value) =>
                            ValidationMixin().validate(value!, "latitude"),
                        onFieldSubmitted: (_) {},
                      ),
                      SizedBox(
                        height: SizeConfig.height * 2,
                      ),
                      Text(
                        "Longitude",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: SizeConfig.height,
                      ),
                      InputTextField(
                        title: "longitude",
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: longitudeController,
                        validate: (value) =>
                            ValidationMixin().validate(value!, "longitude"),
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
                        onFieldSubmitted: (_) {
                          submit(context);
                        },
                      ),
                       SizedBox(
                        height: SizeConfig.height * 2,
                      ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     await showBottomSheet(context);
                      //   },
                      //   child: Text("Upload Image"),
                      // ),
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
        
        
        final map = Hotel(
          hotelName: hotelNameController.text,
          hotelCity: hotelCityController.text,
          hotelAddress: hotelAddressController.text,
          latitude: double.parse(latitudeController.text),
          longitude: double.parse(longitudeController.text),
          hotelDescription: hotelDescriptionController.text,
          hotelAmneties: hotelAmnetiesController.text,
          hotelImage: hotelImageUrl, 
        ).toJson();

        Navigator.pop(context);
        Navigator.pop(context);

            await Provider.of<HotelProvider>(context, listen: false).addHotelData(
            context,
            hotelNameController.text,
            hotelCityController.text,
            hotelAddressController.text,
            double.parse(latitudeController.text),
            double.parse(longitudeController.text),
            hotelDescriptionController.text,
            hotelAmnetiesController.text,
            hotelImageUrl,
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
                            maxHeight: 640,);
                          if (xFile != null) {
                            final uint8List = await xFile.readAsBytes();
                                // Provider.of<HotelProvider>(context, listen: false)
                                // .addHotelImage(context,image: base64Encode(uint8List));
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
                            // Provider.of<HotelProvider>(context, listen: false)
                            //     .addHotelImage(context,image: base64Encode(uint8List));

                              
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
