import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/widgets/home_screen_widgets.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final Stream<QuerySnapshot> urgent = FirebaseFirestore.instance.collection('urgent').snapshots();

  final Stream<QuerySnapshot> advert = FirebaseFirestore.instance.collection('advert').snapshots();

  final Stream<QuerySnapshot> news = FirebaseFirestore.instance.collection('news').snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: AdvertSteamBuilder(stream: urgent),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25, bottom: 15),
          child: Text(
            "Кабарлар".tr,
            style: MyTextStyle.homeTheme,
          ),
        ),
        Container(
          child: AdvertSteamBuilder(stream: news, isGrid: false),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25, bottom: 15),
          child: Text(
            "Башка жарнамалар".tr,
            style: MyTextStyle.homeTheme,
          ),
        ),
        Container(
          child: AdvertSteamBuilder(stream: advert),
        ),
      ],
    );
  }
}
