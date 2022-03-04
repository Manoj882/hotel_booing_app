import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/constants/constant.dart';
import '/models/hotel_model.dart';

class AddHotel extends StatelessWidget {
  const AddHotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    final collection = fireStore.collection(HotelConstant.hotel);


    return Scaffold(
      appBar: AppBar(
        title: Text("Add Hotel"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: basePadding,
        child: StreamBuilder(
            stream: collection
            .orderBy("name")
            .snapshots(), 
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // print(((snapshot.data!)as DocumentSnapshot).data().toString());

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              print(snapshot.data!.docs.last.data());
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index].data() as Map;
                  final hotel = HotelModel.fromJson(data);
                  return Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.indigo[700],
                        child: Center(
                          child: Text(
                            hotel.name,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: basePadding,
                          child: Column(
                            children: [
                              Text(
                                hotel.city,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                hotel.address,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                shrinkWrap: true,
              );
            }),
      ),
    );
  }
}
