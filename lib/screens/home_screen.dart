import 'package:flutter/material.dart';
import 'package:hotel_booking_app/providers/user_provider.dart';
import 'package:hotel_booking_app/utils/curved_body_widget.dart';
import 'package:hotel_booking_app/utils/navigate.dart';
import 'package:hotel_booking_app/utils/size_config.dart';
import 'package:provider/provider.dart';

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
            Consumer<UserProvider>(
              builder: (_,data, __) {
                return UserAccountsDrawerHeader(
                  accountName: Text(data.user.name ?? "No Name"),
                  accountEmail: Text(data.user.email ?? "No Email"),
                  currentAccountPicture: Hero(
                    tag: "image-url",
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(data.user.image ?? image),
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
