import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_booking_app/constants/constant.dart';

import '../../models/hotel_model.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({required this.hotelId, Key? key}) : super(key: key);

  final String hotelId;

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(HotelConstant.hotelCollection)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GoogleMap(
              mapType: MapType.normal,
              markers: {
                Marker(
                  markerId: const MarkerId("markerId"),
                  position: LatLng(
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.hotelId)['latitude'],
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.hotelId)['longitude'],
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                ),
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.hotelId)["latitude"],
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.hotelId)["longitude"],
                ),
                zoom: 14.5,
              ),
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _controller = controller;
                });
              },
            );
          }),
    );
  }
}
