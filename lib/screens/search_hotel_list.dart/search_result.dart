import 'package:flutter/material.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
import 'package:hotel_booking_app/screens/search_hotel_list.dart/search_field.dart';
import 'package:hotel_booking_app/screens/search_hotel_list.dart/search_screen.dart';
import 'package:hotel_booking_app/widgets/hotel_card.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen(this.searchValue, {Key? key}) : super(key: key);

  final String searchValue;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  RangeValues values = const RangeValues(1, 100);
  RangeLabels labels = const RangeLabels("1", "100");
  @override
  Widget build(BuildContext context) {
    Provider.of<HotelProvider>(context, listen: false)
        .searchHotels(widget.searchValue);
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => SearchScreen(
              autoFocus: true,
              value: widget.searchValue,
            ),
          ),
        );
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.chevron_left_outlined,
                            color: Colors.black54,
                            size: 26,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => SearchScreen(
                                  autoFocus: true,
                                  value: widget.searchValue,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SearchField(
                          value: widget.searchValue,
                          autoFocus: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  getSearchHotels(
                    context,
                    widget.searchValue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchHotels(BuildContext context, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search results for $name',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        Consumer<HotelProvider>(builder: (_, data, __) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: data.listOfSearchedHotel.length,
            itemBuilder: (context, index) {
              return HotelCard(
                hotel: data.listOfSearchedHotel[index],
              );
            },
          );
        }),
      ],
    );
  }
}
