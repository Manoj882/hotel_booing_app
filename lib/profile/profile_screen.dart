import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:hotel_booking_app/utils/text_form_field.dart';
import 'package:hotel_booking_app/utils/validation_mixin.dart';
import 'package:hotel_booking_app/widgets/general_alert_dialog.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({required this.imageUrl, Key? key}) : super(key: key);

  final String imageUrl;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Hero(
                  tag: "image-url",
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                    radius: SizeConfig.height * 10,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height * 2,
                ),
                Text(
                  "Edit Your Profile",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: SizeConfig.height * 2,
                ),
                InputTextField(
                  title: "Name",
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                  validate: (value) =>
                      ValidationMixin().validate(value!, "name"),
                  onFieldSubmitted: (_) {},
                ),
                SizedBox(
                  height: SizeConfig.height * 1.5,
                ),
                InputTextField(
                  title: "Address",
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  controller: addressController,
                  validate: (value) =>
                      ValidationMixin().validate(value!, "address"),
                  onFieldSubmitted: (_) {},
                ),
                SizedBox(
                  height: SizeConfig.height * 1.5,
                ),
                InputTextField(
                  title: "Age",
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  controller: ageController,
                  validate: (value) => ValidationMixin().validateAge(value!),
                  onFieldSubmitted: (_) {},
                ),
                SizedBox(
                  height: SizeConfig.height * 3,
                ),
                ElevatedButton(
                  onPressed: () async{
                    if (formKey.currentState!.validate()) {
                      try{
                      GeneralAlertDialog().customLoadingDialog(context);

                      final map = Provider.of<UserProvider>(context, listen: false)
                          .updateUser(
                        name: nameController.text,
                        address: addressController.text,
                        age: int.parse(ageController.text),
                      );
                      // print(map);
                      final firestore = FirebaseFirestore.instance;
                      await firestore.collection(UserConstants.userCollection).add(map);

                      Navigator.pop(context);
                      Navigator.pop(context);
                      }catch(ex){
                        Navigator.pop(context);
                        print(ex.toString());
                      }
                    }
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
