import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/widgets/home_screen_widgets.dart';
import 'package:get/get.dart';

class NewsScreen extends StatelessWidget {
  final Stream<QuerySnapshot> news = FirebaseFirestore.instance.collection('news').orderBy("data",descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0, bottom: 15),
            child: Text(
              "Кабарлар".tr,
              style: MyTextStyle.homeTheme,
            ),
          ),
          AdvertSteamBuilder(stream: news, isGrid: false),
        ],
      ),
    );
  }
}
