
import 'package:flutter/material.dart';
import '/utils/curved_body_widget.dart';
import '/utils/firebase_helper.dart';
import '/utils/size_config.dart';
import '/utils/text_form_field.dart';
import '/utils/validation_mixin.dart';
import 'package:provider/provider.dart';

import '/constants/constant.dart';
import '/providers/user_provider.dart';
import '/widgets/general_alert_dialog.dart';

class AddHotelsScreen extends StatelessWidget {
  AddHotelsScreen({Key? key}) : super(key: key);

  final hotelNameController = TextEditingController();
  final hotelAddressController = TextEditingController();
  final hotelCityController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Hotel"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Form(
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
                Center(
                  child: ElevatedButton(
                    onPressed: () => submit(context),
                    child: Text("Submit"),
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
        final uid = Provider.of<UserProvider>(context, listen: false).user.uuid;
        final map = {
          "hotelName": hotelNameController.text,
          "hotelAddress": hotelAddressController.text,
          "hotelCity": hotelCityController.text,
          "uuid": uid,
        };
        await FirebaseHelper().addOrUpdateFirebaseContent(
          context,
          collectionId: HotelConstant.hotelCollection,
          whereId: UserConstants.userId,
          whereValue: uid,
          map: map,
        );
        
      } catch (ex) {
        GeneralAlertDialog().customAlertDialog(context, ex.toString());
      }
    }
  }
}
