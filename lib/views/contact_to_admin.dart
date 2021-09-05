import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/models/admin.dart';
import 'package:nookat/service/get_url_service.dart';
import 'package:readmore/readmore.dart';

class ContactToAdmin extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('admin').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: Get.width / 2,
              child: Image.asset(
                "assets/image/nookat_admin.jpeg",
                width: double.infinity,
                height: Get.width / 2,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: ReadMoreText(
                "Мен Бугун кундогудон ойлуу турам негедимр журогум да толкуп уламМен Бугун кундогудон ойлуу турам негедимр журогум да толкуп уламМен Бугун кундогудон ойлуу турам негедимр журогум да толкуп уламМен Бугун кундогудон ойлуу турам негедимр журогум да толкуп уламМен Бугун кундогудон ойлуу турам негедимр журогум да толкуп уламМен Бугун кундогудон ойлуу турам негедимр журогум да толкуп уламМен Бугун кундогудон ойлуу турам негедимр журогум да толкуп уламМен Бугун кундогудон ойлуу турам негедимр журогум да толкуп улам",
                colorClickableText: MyColors.myRed,
                moreStyle: MyTextStyle.moreTextStyle,
                trimCollapsedText: "Дагы оку".tr,
                trimExpandedText: "Жабуу".tr,
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Интернет байланышында ката бар'.tr));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    Admin admin = Admin(
                      password: data["password"],
                      description: data['descriptions'],
                      name: data['name'],
                      whatsapp: data['whatsapp'],
                      telegram: data['telegram'],
                      phone: data['phone'],
                    );
                    return Container(
                      margin: const EdgeInsets.all(10.0),
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
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 5.0, left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              admin.name,
                              overflow: TextOverflow.ellipsis,
                              style: MyTextStyle.homeUser,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              admin.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: MyTextStyle.homeTitle,
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/viber.svg",
                                    color: MyColors.phoneColor,
                                    width: 20,
                                  ),
                                  Text(
                                    admin.phone,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: MyTextStyle.settingItemTextStyle,
                                  ),
                                  Icon(
                                    Icons.done_all,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: (){
                                  UrlService().launchWhatsApp(admin.whatsapp, "salam");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/whatsapp.svg",
                                      width: 30,
                                    ),
                                    Text(
                                      admin.whatsapp,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: MyTextStyle.settingItemTextStyle,
                                    ),
                                    Icon(
                                      Icons.done_all,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/telegram.svg",
                                    width: 25,
                                  ),
                                  Text(
                                    admin.telegram,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: MyTextStyle.settingItemTextStyle,
                                  ),
                                  Icon(
                                    Icons.done_all,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
