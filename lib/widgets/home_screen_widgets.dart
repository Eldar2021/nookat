import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/models/advert.dart';
import 'package:nookat/service/get_url_service.dart';
import 'package:nookat/views/advert_detail_screen.dart';
import 'package:progressive_image/progressive_image.dart';

class AdvertSteamBuilder extends StatelessWidget {
  const AdvertSteamBuilder({
    Key? key,
    required Stream<QuerySnapshot<Object?>> stream,
    this.isGrid = true,
  })  : stream = stream,
        super(key: key);

  final Stream<QuerySnapshot<Object?>> stream;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Интернет байланышында ката бар'.tr));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return isGrid == true
            ? GridView(
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: Get.width / 2, //200,
                  childAspectRatio: 2.0 / 3.5,
                ),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  Advert advert = Advert(
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
                  return AdvertCard(advert: advert);
                }).toList(),
              )
            : ListView(
                shrinkWrap: true,
                primary: false,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  Advert advert = Advert(
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
                  );
                  return NewsCard(advert: advert);
                }).toList(),
              );
      },
    );
  }
}

class AdvertCard extends StatelessWidget {
  const AdvertCard({
    Key? key,
    required this.advert,
  }) : super(key: key);

  final Advert advert;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(AdvertDetailScreen(advert: advert));
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
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
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: double.infinity,
                      child: advert.photos!.isEmpty
                          ? Image.asset(
                              "assets/image/nookat.jpeg",
                              fit: BoxFit.fill,
                            )
                          : CachedNetworkImage(
                              imageUrl: advert.photos![0],
                              placeholder: (context, url) => Image.asset("assets/image/logo.png"),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/image/logo.png"),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, right: 7.0, bottom: 1.0, left: 3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          advert.title,
                          overflow: TextOverflow.ellipsis,
                          style: MyTextStyle.homeTitle,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${advert.user}",
                                  overflow: TextOverflow.ellipsis,
                                  style: MyTextStyle.homeUser,
                                ),
                              ),
                              advert.data != null
                                  ? Expanded(
                                      child: Text(
                                        advert.data!,
                                        overflow: TextOverflow.ellipsis,
                                        style: MyTextStyle.homeData,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Text(
                          advert.descriptions,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: MyTextStyle.homeDescription,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            advert.phone != ""
                                ? IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/icons/viber.svg",
                                      width: 20,
                                    ),
                                    onPressed: () {
                                      UrlService().launchCaller(advert.phone);
                                    },
                                  )
                                : Container(),
                            advert.whatsapp != ""
                                ? IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/icons/whatsapp.svg",
                                      width: 30,
                                    ),
                                    onPressed: () {
                                      UrlService().launchWhatsApp(advert.whatsapp, "salam");
                                    },
                                  )
                                : Container(),
                            advert.telegram != ""
                                ? IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/icons/telegram.svg",
                                      width: 25,
                                    ),
                                    onPressed: () {
                                      UrlService().launchTelegram(advert.telegram);
                                    },
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            advert.price != ""
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: MyColors.priceBackColor,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        advert.price!,
                        style: MyTextStyle.homeCategory,
                      ),
                    ),
                  )
                : Container(),
            advert.advertCategory != ""
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: MyColors.categoryBackColor,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        "${advert.advertCategory}".tr,
                        style: MyTextStyle.homeCategory,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.advert,
  }) : super(key: key);

  final Advert advert;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(AdvertDetailScreen(advert: advert));
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  height: Get.width / 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: advert.photos!.isEmpty
                        ? Image.asset(
                            "assets/image/nookat.jpeg",
                            width: 100,
                            height: Get.width / 2,
                            fit: BoxFit.cover,
                          )
                        : ProgressiveImage(
                            placeholder: AssetImage("assets/image/logo.png"),
                            image: NetworkImage(advert.photos![0]),
                            thumbnail: NetworkImage(advert.photos![0]),
                            fit: BoxFit.cover,
                            width: 1000,
                            height: 1000,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        advert.title,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyle.homeTitle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              advert.user,
                              overflow: TextOverflow.ellipsis,
                              style: MyTextStyle.homeUser,
                            ),
                          ),
                          Text(
                            "${advert.data}",
                            overflow: TextOverflow.ellipsis,
                            style: MyTextStyle.homeData,
                          ),
                        ],
                      ),
                      Text(
                        advert.descriptions,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyle.homeDescription,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
