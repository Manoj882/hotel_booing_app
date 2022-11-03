import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/providers/hotel_provider.dart';
import 'package:hotel_booking_app/screens/hotel_screen/hotel_details_screen.dart';
import 'package:hotel_booking_app/screens/search_hotel_list.dart/search_result.dart';
import 'package:hotel_booking_app/screens/search_hotel_list.dart/search_screen.dart';
import 'package:hotel_booking_app/utils/navigate.dart';
import 'package:hotel_booking_app/widgets/hotel_card.dart';
import 'package:provider/provider.dart';

import '../../models/hotel_model.dart';
import '../../providers/user_provider.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {this.value, this.autoFocus = true, this.isSearchScreen = true, Key? key})
      : super(key: key);

  final String? value;
  final bool autoFocus;
  final bool isSearchScreen;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Autocomplete<Hotel>(
      optionsViewBuilder: (context, function, hotels) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: MediaQuery.of(context).size.width - 80,
            margin: EdgeInsets.zero,
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: hotels.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    navigate(
                      context,
                      HotelDetailsScreen(
                          hotel: hotels.toList()[index], user: user),
                    );
                  },
                  child: HotelCard(
                    hotel: hotels.toList()[index],
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
          ),
        );
      },
      fieldViewBuilder: (context, searchController, focusNode, function) {
        searchController.text = value ?? '';
        return TextFormField(
          controller: searchController,
          autofocus: autoFocus,
          focusNode: focusNode,
          onTap: () {
            log(value.toString());
            if (isSearchScreen) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => SearchScreen(
                    autoFocus: true,
                    value: searchController.text,
                  ),
                ),
              );
            }
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: 'Search hotel...',
            suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
              },
              icon: const Icon(
                Icons.clear_outlined,
                size: 24,
                color: Colors.black45,
              ),
            ),
          ),
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (newValue) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => SearchResultScreen(
                  newValue,
                ),
              ),
            );
          },
        );
      },
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Hotel>.empty();
        }
        Provider.of<HotelProvider>(context, listen: false).searchHotels(
          textEditingValue.text.trim(),
        );
        return Provider.of<HotelProvider>(context, listen: false)
            .listOfSearchedHotel;
      },
    );
  }
}
