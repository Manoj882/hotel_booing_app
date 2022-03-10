import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/navigate.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
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
        child: Column(
          children: [
            Consumer<UserProvider>(
              builder: (_,data, __) {
                return UserAccountsDrawerHeader(
                  accountName: Text(data.user.name ?? "No Name"),
                  accountEmail: Text(data.user.email ?? "No Email"),
                  currentAccountPicture: Hero(
                    tag: "image-url",
                    child: SizedBox(
                          height: SizeConfig.height * 16,
                          width: SizeConfig.height * 16,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(SizeConfig.height * 8),
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
              }
            ),
            ListTile(
              leading: Icon(
                Icons.person_outlined,
              ),
              title: Text("Profile"),
              onTap: () => navigate(context, ProfileScreen(imageUrl: image)),
            ),
          ],
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
}
