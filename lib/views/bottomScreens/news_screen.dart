import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nookat/widgets/home_screen_widgets.dart';

class NewsScreen extends StatelessWidget {
  final Stream<QuerySnapshot> news = FirebaseFirestore.instance.collection('news').snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: AdvertSteamBuilder(stream: news, isGrid: false),
      ),
    );
  }
}
