import 'package:flutter/material.dart';
import 'package:hotel_booking_app/screens/search_hotel_list.dart/search_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({this.value, this.autoFocus = true, Key? key})
      : super(key: key);

  final String? value;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor:
                          Theme.of(context).textTheme.headline6!.color,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.chevron_left_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: SearchField(
                        value: value ?? '',
                        autoFocus: autoFocus,
                        isSearchScreen: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
