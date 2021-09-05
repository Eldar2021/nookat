import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:get/get.dart';

class MyCategoryListStreamBuilder extends StatelessWidget {
  MyCategoryListStreamBuilder({required this.function});

  final Function function;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('advert').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Интернет байланышында ката бар.'.tr));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          shrinkWrap: true,
          primary: false,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                function(data["AdvertCategory"]);
              },
              child: Container(
                margin: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: MyColors.whiteColor,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "${data["AdvertCategory"]}",
                      style: MyTextStyle.homeCategory,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
