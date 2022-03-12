import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/models/user.dart';
import '/providers/user_provider.dart';
import '/screens/hotel_screen/add_hotels_screen.dart';
import '/utils/curved_body_widget.dart';
import '/utils/navigate.dart';
import '/utils/size_config.dart';
import 'package:provider/provider.dart';

import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final image = "assets/images/profile.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<UserProvider>(builder: (_, data, __) {
                return UserAccountsDrawerHeader(
                  accountName: Text(data.user.name ?? "No Name"),
                  accountEmail: Text(data.user.email ?? "No Email"),
                  currentAccountPicture: Hero(
                    tag: "image-url",
                    child: SizedBox(
                      height: SizeConfig.height * 16,
                      width: SizeConfig.height * 16,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(SizeConfig.height * 8),
                        child: data.user.image == null
                            ? Image.asset(
                                image,
                                fit: BoxFit.cover,
                              )
                            : Image.memory(
                                base64Decode(data.user.image!),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                );
              }),
        
              
              
                buildListTile(
                context,
                iconData: Icons.person_outlined,
                label: "Profile",
                widget: ProfileScreen(imageUrl: image),
              ),
                buildListTile(
                context,
                iconData: Icons.hotel_outlined,
                label: "Add Hotel",
                widget: AddHotelsScreen(),
              ),
            ],
          ),
        ),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Text("Hotel Booking"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(
    BuildContext context, {
    required IconData iconData,
    required String label,
    required Widget widget,
  }) {
    return ListTile(
      leading: Icon(
        iconData,
      ),
      title: Text(label),
      onTap: () => navigate(
        context,
        widget,
      ),
    );
  }
}
