import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/models/information_about_app.dart';
import 'package:nookat/myLanguage/my_text.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';

class InformationScreen extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('information').snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25, bottom: 15),
          child: Text(
            "Колдонуу инструкциясы".tr,
            style: MyTextStyle.homeTheme,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: MyColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: MyColors.boxShadowColor,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ноокат жарнама",
                overflow: TextOverflow.ellipsis,
                style: MyTextStyle.homeUser,
              ),
              const SizedBox(height: 15),
              ReadMoreText(
                "${MyText.informationTextKg}",
                style: MyTextStyle.homeTitle,
                trimLines: 5,
                colorClickableText: MyColors.myRed,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Дагы оку'.tr,
                trimExpandedText: 'Жабуу'.tr,
                moreStyle: MyTextStyle.moreTextStyle,
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
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
                InformationAboutApp informationAboutApp = InformationAboutApp(
                  title: data['title'],
                  description: data['descriptions'],
                );
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: MyColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.boxShadowColor,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        informationAboutApp.title,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyle.homeUser,
                      ),
                      const SizedBox(height: 15),
                      ReadMoreText(
                        informationAboutApp.description,
                        style: MyTextStyle.homeTitle,
                        trimLines: 5,
                        colorClickableText: MyColors.myRed,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Дагы оку'.tr,
                        trimExpandedText: 'Жабуу'.tr,
                        moreStyle: MyTextStyle.moreTextStyle,
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
