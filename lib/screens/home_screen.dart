import 'package:flutter/material.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/navigate.dart';
import 'package:hotel_booking_app/utils/size_config.dart';

import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final image = "https://resize.indiatvnews.com/en/resize/newbucket/715_-/2020/08/buddha-1596979292.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Manoj BK"),
              accountEmail: Text("manojbk488@gmail.com"),
              currentAccountPicture: Hero(
                tag: "image-url",
                child: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                ),
              ),
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
