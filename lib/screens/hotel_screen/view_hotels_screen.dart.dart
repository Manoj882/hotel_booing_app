import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/constant.dart';
import 'package:hotel_booking_app/utils/size_config.dart';

class ViewHotelScreen extends StatelessWidget {
  const ViewHotelScreen({Key? key}) : super(key: key);

  final String image =
      "https://www.nepal-travel-guide.com/wp-content/uploads/2020/05/image-156.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FF),
      appBar: AppBar(
        title: Text("Hotels"),
      ),
      body: Padding(
        padding: basePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Hotel App",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: SizeConfig.height * 1.5,
            ),
            Text(
              "Choose your destination",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
            SizedBox(
              height: SizeConfig.height * 2,
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(SizeConfig.height * 2),
              shadowColor: Color(0x55434343),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for hotel",
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.height * 2,
            ),
            DefaultTabController(
              length: 3,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TabBar(
                        indicatorColor: Color(0xFFFE8C68),
                        unselectedLabelColor: Color(0xFF555555),
                        labelColor: Color(0xFFFE8C68),
                        labelPadding: EdgeInsets.symmetric(horizontal: SizeConfig.height * 1),
                        tabs: [
                          Tab(
                            text: "Populars",
                          ),
                          Tab(
                            text: "Trends",
                          ),
                          Tab(
                            text: "Favorites",
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.height * 2,),
                      Container(
                        height: 300,
                        child: TabBarView(
                          children: [
                            Container(
                              child: ListView(
                               
                                scrollDirection: Axis.horizontal,
                                children: [
                                  hotelCard(
                                    context,
                                    imageUrl: image,
                                    hotelName: "Annapurna",
                                    location: "Jamal",
                                    rating: 4,
                                  ),
                                  hotelCard(
                                    context,
                                    imageUrl: image,
                                    hotelName: "Annapurna",
                                    location: "Jamal",
                                    rating: 4,
                                  ),
                                  hotelCard(
                                    context,
                                    imageUrl: image,
                                    hotelName: "Annapurna",
                                    location: "Jamal",
                                    rating: 4,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: ListView(
                                
                                scrollDirection: Axis.horizontal,
                                children: [
                                  hotelCard(
                                    context,
                                    imageUrl: image,
                                    hotelName: "Annapurna",
                                    location: "Jamal",
                                    rating: 4,
                                  ),
                                  hotelCard(
                                    context,
                                    imageUrl: image,
                                    hotelName: "Annapurna",
                                    location: "Jamal",
                                    rating: 4,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: ListView(
                                
                                scrollDirection: Axis.horizontal,
                                children: [
                                  hotelCard(
                                    context,
                                    imageUrl: image,
                                    hotelName: "Annapurna",
                                    location: "Jamal",
                                    rating: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hotelCard(
    BuildContext context, {
    required String imageUrl,
    required String hotelName,
    required String location,
    required int rating,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 0,
      child: InkWell(
        onTap: (){},
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              scale: 2,
            ),
          ),
          width: 200,
          child: Padding(
            padding: basePadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //for rating
                    for (var i = 0; i < rating; i++)
                      Icon(
                        Icons.star_outlined,
                        color: Color(0xFFFE8C68),
                      ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotelName,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        location,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
