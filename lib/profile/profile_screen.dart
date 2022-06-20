import 'dart:convert';
import 'package:flutter/material.dart';
import '/constants/constant.dart';
import '/providers/user_provider.dart';
import '/utils/curved_body_widget.dart';
import '/utils/firebase_helper.dart';
import '/utils/size_config.dart';
import '/utils/text_form_field.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({required this.imageUrl,Key? key}) : super(key: key);

  final String imageUrl;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isAdmin = false;

  @override
  Widget build(BuildContext context) {
    
   
    final profileData = Provider.of<UserProvider>(context).user;
    nameController.text = profileData.name ?? "";
    addressController.text = profileData.address ?? "";
    ageController.text =
        profileData.age != null ? profileData.age.toString() : "";

    _isAdmin = profileData.isAdmin;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: basePadding,
              child: Column(
                children: [
                  Hero(
                    tag: "image-url",
                    child: Stack(
                      children: [
                        SizedBox(
                          height: SizeConfig.height * 16,
                          width: SizeConfig.height * 16,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(SizeConfig.height * 8),
                            child: profileData.image == null
                                ? Image.asset(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    base64Decode(profileData.image!),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: -20,
                          child: RawMaterialButton(
                            elevation: 1,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                color: Colors.black38,
                                size: 40,
                              ),
                            ),
                            fillColor: Colors.grey.shade200,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            onPressed: () async {
                              await showBottomSheet(context);
                            },
                          ),
                        ),
                      ],
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
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        
                        try {
                          final map =
                              Provider.of<UserProvider>(context, listen: false)
                                  .updateUser(
                            name: nameController.text,
                            address: addressController.text,
                            age: int.parse(ageController.text),
                            isAdmin: _isAdmin,
                            
   
                          );
                          
                        
                          
                          await FirebaseHelper().addOrUpdateFirebaseContent(
                            context,
                            collectionId: UserConstants.userCollection,
                            whereId: UserConstants.userId,
                            whereValue: profileData.uuid,
                            map: map,
                          );
                          Navigator.pop(context);
                        } catch(ex){
                          Navigator.pop(context);
                          GeneralAlertDialog().customAlertDialog(context, ex.toString());
                        }
                      
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
                              maxHeight: 700,
                              maxWidth: 700,
                              imageQuality: 100,

                              ); 
                          if (xFile != null) {
                            final uint8List = await xFile.readAsBytes();
                            final map = Provider.of<UserProvider>(context,
                                    listen: false)
                                .updateUserImage(base64Encode(uint8List));
                          }
                        },
                        iconData: Icons.photo_camera_outlined,
                        label: "Camera",
                      ),
                      buildPhotoChooseOption(
                        context,
                        function: () async {
                          final xFile = await imagePicker.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 700,
                              maxWidth: 700,
                              imageQuality: 100,
                              );
                          if (xFile != null) {
                            final uint8List = await xFile.readAsBytes();
                            Provider.of<UserProvider>(context, listen: false)
                                .updateUserImage(base64Encode(uint8List));
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
