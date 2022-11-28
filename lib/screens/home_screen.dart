import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
import 'package:hotel_booking_app/screens/book_room/all_user_booked_room.dart';
import 'package:hotel_booking_app/screens/book_room/booking_history.dart';
import 'package:hotel_booking_app/screens/book_room/list_of_booking.dart';
import 'package:hotel_booking_app/screens/login_screen.dart';
import 'package:hotel_booking_app/screens/search_hotel_list.dart/search_screen.dart';
import 'package:hotel_booking_app/widgets/custom_switch.dart';
import 'package:hotel_booking_app/widgets/general_alert_dialog.dart';
import 'package:hotel_booking_app/widgets/hotel_card.dart';
import '/providers/user_provider.dart';
import '/screens/hotel_screen/add_hotels_screen.dart';
import '/utils/curved_body_widget.dart';
import '/utils/navigate.dart';
import '/utils/size_config.dart';
import 'package:provider/provider.dart';
import '../profile/profile_screen.dart';
import 'hotel_screen/hotel_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final image = "assets/images/profile.png";
  final String imageOfHotel =
      "https://www.nepal-travel-guide.com/wp-content/uploads/2020/05/image-156.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SearchScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.search_outlined,
            ),
          ),
        ],
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
              Provider.of<UserProvider>(context).user.isAdmin
                  ? buildListTile(
                      context,
                      iconData: Icons.book_online_outlined,
                      label: "Reservations",
                      widget: const AllUserBookedRoom(),
                    )
                  : buildListTile(
                      context,
                      iconData: Icons.book_online_outlined,
                      label: "Reservation",
                      widget: const ListOfBookingRoom(),
                    ),
              if (!Provider.of<UserProvider>(context).user.isAdmin)
                buildListTile(
                  context,
                  iconData: Icons.history_outlined,
                  label: "Booking History",
                  widget: BookingHistoryScreen(),
                ),
              CustomSwitch(),
              Divider(thickness: 1,),
              ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onTap: () async {
                  try {
                    GeneralAlertDialog().customLoadingDialog(context);
                    await FirebaseAuth.instance.signOut();
                    await GoogleSignIn().signOut();

                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                    );
                  } on FirebaseAuthException catch (ex) {
                    Navigator.of(context).pop();
                    await GeneralAlertDialog()
                        .customAlertDialog(context, ex.toString());
                  } catch (ex) {
                    Navigator.of(context).pop();
                    await GeneralAlertDialog()
                        .customAlertDialog(context, ex.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: CurvedBodyWidget(
        widget: FutureBuilder(
          future: Provider.of<HotelProvider>(context, listen: true)
              .fetchHotelData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final listOfHotel = Provider.of<HotelProvider>(context).listOfHotel;
            final user = Provider.of<UserProvider>(context).user;

            return listOfHotel.isEmpty
                ? Center(
                    child: Text(
                      "Any hotel is not available for booking",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: SizeConfig.width * 3,
                              ),
                              child: Text(
                                "Available Hotels",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Provider.of<UserProvider>(context).user.isAdmin
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => AddHotelsScreen(
                                              hotelImageUrl: imageOfHotel,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Add Hotel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.height * 1.5,
                        ),
                        SizedBox(
                          height: SizeConfig.height * 1.5,
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: listOfHotel.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => navigate(
                                context,
                                HotelDetailsScreen(
                                  hotel: listOfHotel[index],
                                  user: user,
                                ),
                              ),
                              child: HotelCard(
                                hotel: listOfHotel[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: SizeConfig.height * 1.5,
                            );
                          },
                          shrinkWrap: true,
                          primary: false,
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildListTile(
    BuildContext context, {
    IconData? iconData,
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
