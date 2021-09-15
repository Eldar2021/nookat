import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:get/get.dart';

class MyCategoryListStreamBuilder extends StatelessWidget {
  MyCategoryListStreamBuilder({required this.function});

  final Function function;
  final List<String> categories = [];

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
        final category = snapshot.data!.docs;
        for (var rest in category) {
          Map<String, dynamic> data = rest.data()! as Map<String, dynamic>;
          if (categories.contains(data["AdvertCategory"])) {
            //categories.add(data["AdvertCategory"]);
          } else {
            categories.add(data["AdvertCategory"]);
          }
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            String cat = categories[index];
            return GestureDetector(
              onTap: () {
                function(cat);
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
                      "$cat",
                      style: MyTextStyle.homeCategory,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
