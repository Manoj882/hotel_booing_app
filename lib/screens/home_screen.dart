import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
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
  final String imageOfHotel =
      "https://www.nepal-travel-guide.com/wp-content/uploads/2020/05/image-156.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Hotel"),
        centerTitle: false,
        actions: [
          Provider.of<UserProvider>(context).user.isAdmin
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddHotelsScreen(hotelImageUrl: imageOfHotel,),
                          ),
                        );
                      },
                      child: Text(
                        "Add Hotel",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
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
              (Provider.of<UserProvider>(context).user.isAdmin)
                  ? buildListTile(
                      context,
                      iconData: Icons.hotel_outlined,
                      label: "Add Hotel",
                      widget: AddHotelsScreen(hotelImageUrl: imageOfHotel,),
                    )
                  : buildListTile(
                      context,
                      iconData: Icons.person_outlined,
                      label: "Profile",
                      widget: ProfileScreen(imageUrl: image),
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final listOfHotel =
                  Provider.of<HotelProvider>(context).listOfHotel;

              return listOfHotel.isEmpty
                  ? Center(
                      child: Text("Any hotel is not available for booking"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Available Hotels",
                          ),
                          SizedBox(
                            height: SizeConfig.height * 1.5,
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: listOfHotel.length,
                            itemBuilder: (context, index) {
                              return hotelCard(
                                context,
                                hotelName: listOfHotel[index].hotelName,
                                hotelAddress: listOfHotel[index].hotelAddress,
                                hotelCity: listOfHotel[index].hotelCity,
                                imageUrl: imageOfHotel,
                              );

                              // return Card(
                              //   elevation: 3,
                              //   child: Column(
                              //     children: [
                              //       Container(
                              //         height: 150,
                              //         // color: Colors.redAccent,
                              //         // child: Center(
                              //         //   child: Text(listOfHotel[index].hotelName,
                              //         //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              //         //     fontWeight: FontWeight.bold,
                              //         //     color: Colors.white,
                              //         //   ),
                              //         //   ),
                              //         // ),
                              //         decoration: BoxDecoration(
                              //           image: DecorationImage(
                              //             image: NetworkImage(imageOfHotel),
                              //             fit: BoxFit.cover,
                              //           ),
                              //         ),
                              //       ),
                              //       Text(listOfHotel[index].hotelAddress),
                              //       Text(listOfHotel[index].hotelCity),
                              //     ],
                              //   ),
                              // );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: SizeConfig.height * 1.5,
                              );
                            },
                            shrinkWrap: true,
                          ),
                        ],
                      ),
                    );
            }),
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

  hotelCard(
    BuildContext context, {
    required String hotelName,
    required String hotelAddress,
    required String hotelCity,
    required String imageUrl,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
                 Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                      scale: 2,
                    ),
                  ),
                ),
                
              
              SizedBox(
                width: SizeConfig.width * 4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelName,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: SizeConfig.height),

                  Row(
                    children: [
                      Icon(Icons.place_outlined,
                      color: Colors.black38,       
                      ),
                      Text(
                        hotelAddress,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black38,
                        ),
                      ),
                      Text(", "),
                      Text(
                        hotelCity,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
