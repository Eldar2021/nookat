import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/controler/read_category_controller.dart';
import 'package:nookat/models/advert_category.dart';

class ReadCategory extends StatelessWidget {
  final Function function;

  ReadCategory({required this.function});

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('category').snapshots();

  final ReadController readController = Get.put(ReadController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return GridView(
            shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: Get.width / 2, //200,
              childAspectRatio: 4 / 1,
            ),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              AdvertCategory advertCategory = AdvertCategory(
                description: data['descriptions'],
                title: data['title'],
                icon: data["photos"],
              );
              return GestureDetector(
                onTap: () {
                  function(advertCategory.title);
                  readController.show(advertCategory.title);
                },
                child: Container(
                  padding: const EdgeInsets.all(7.0),
                  margin: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    color: MyColors.priceBackColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        advertCategory.title,
                        style: MyTextStyle.homeCategory,
                      ),
                      Obx(
                        () => Visibility(
                          visible: readController.visible.value == advertCategory.title? true : false,
                          child: Icon(Icons.check_outlined, color: MyColors.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }
        return Container();
      },
    );
  }
}
