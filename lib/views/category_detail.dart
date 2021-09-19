import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/models/advert.dart';
import 'package:nookat/widgets/home_screen_widgets.dart';

class CategoryDetailStream extends StatelessWidget {
  CategoryDetailStream({
    required this.category,
  });

  final Map<String, dynamic> category;
  final Stream<QuerySnapshot> _advertStream = FirebaseFirestore.instance.collection('advert').orderBy("data",descending: true).snapshots();
  final Stream<QuerySnapshot> _urgentStream = FirebaseFirestore.instance.collection('urgent').orderBy("data",descending: true).snapshots();
  final List<Advert> adverts = [];
  final List<Advert> urgent = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text("${category["label"]}".tr),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CategoryDetailStreamFor(usersStream: _urgentStream, category: category, listAdverts: urgent),
            CategoryDetailStreamFor(usersStream: _advertStream, category: category, listAdverts: adverts),
          ],
        ),
      ),
    );
  }
}

class CategoryDetailStreamFor extends StatelessWidget {
  const CategoryDetailStreamFor({
    Key? key,
    required Stream<QuerySnapshot<Object?>> usersStream,
    required this.category,
    required this.listAdverts,
  }) : _usersStream = usersStream, super(key: key);

  final Stream<QuerySnapshot<Object?>> _usersStream;
  final Map<String, dynamic> category;
  final List<Advert> listAdverts;

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
        final booksDB = snapshot.data!.docs;
        for (var rest in booksDB) {
          Map<String, dynamic> data = rest.data()! as Map<String, dynamic>;
          if (category["value"] == data["AdvertCategory"]) {
            final Advert advert = Advert(
              titleDescription: data['titleDescription'],
              descriptions: data['descriptions'],
              title: data['title'],
              price: data['price'],
              whatsapp: data['whatsapp'],
              telegram: data['telegram'],
              phone: data['phone'],
              youtube: data['youtube'],
              photos: data['photos'],
              data: data['data'],
              user: data['user'],
              address: data['address'],
              website: data['website'],
              advertCategory: data["AdvertCategory"],
            );
            listAdverts.add(advert);
          }
        }
        return GridView.builder(
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Get.width / 2, //200,
            childAspectRatio: 2.0 / 3.5,
          ),
          itemCount: listAdverts.length,
          itemBuilder: (context, index) {
            Advert advert = listAdverts[index];
            return AdvertCard(advert: advert);
          },
        );
      },
    );
  }
}
