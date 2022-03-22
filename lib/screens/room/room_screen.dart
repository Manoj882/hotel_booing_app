import 'package:flutter/material.dart';

class ChooseRoomScreen extends StatelessWidget {
  const ChooseRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a room for booking"),
      ),
    );
  }
}
