// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleMapScreen extends StatefulWidget {
//   const GoogleMapScreen({Key? key}) : super(key: key);

//   @override
//   State<GoogleMapScreen> createState() => _GoogleMapScreenState();
// }

// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   Set<Marker> _markers = {};
//   void _onMapCreated(GoogleMapController coontroller) {
//     setState(() {
//       _markers.add(
//         Marker(
//           markerId: MarkerId('id-1'),
//           position: LatLng(27.712021, 85.312950),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GoogleMap(
//           onMapCreated: _onMapCreated,
          
//       initialCameraPosition: CameraPosition(
//         target: LatLng(27.712021, 85.312950),
//         zoom: 15,
//       ),
//     ));
//   }
// }
