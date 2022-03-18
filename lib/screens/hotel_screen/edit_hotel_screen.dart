import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/hotel_model.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
import 'package:hotel_booking_app/utils/image_bottom_sheet.dart';
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
  final String hotelImageUrl;
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
                
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Hotel"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: 
                
                       Form(
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
                        validate: (value) =>
                            ValidationMixin().validate(value!, "city"),
                        onFieldSubmitted: (_) {
                          submit(context);
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.height * 2,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showBottomImageSheet().showBottomSheet(context);
                        },
                        child: Text("Upload Image"),
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
                )
              ),
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

          // uuid: uid,
        );

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);

        // await FirebaseHelper().addData(context, map: map, collectionId: HotelConstant.hotelCollection);
        //add hotel data from HotelProvider

        await Provider.of<HotelProvider>(context, listen: false)
            .updateHotelData(
          context,
          docId: model.id!,
          hotel: hotel
        );
      } catch (ex) {
        print(ex.toString());
      }
    }
  }
}
