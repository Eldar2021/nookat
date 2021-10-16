import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nookat/models/advert.dart';
import 'package:nookat/service/get_url_service.dart';
import 'package:nookat/service/share_service.dart';
import 'package:nookat/views/photo_view_screen.dart';
import 'package:readmore/readmore.dart';

class AdvertImages extends StatelessWidget {
  const AdvertImages({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<dynamic>? images;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: images!.length,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              aspectRatio: 2.0,
              initialPage: 1,
            ),
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  width: double.infinity,
                  height: Get.width / 2,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //   image: NetworkImage(images![itemIndex]),
                  //   fit: BoxFit.cover,
                  // )),
                  child: CachedNetworkImage(imageUrl: images![itemIndex]),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Container(
            color: Colors.black,
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(PhotoViewScreen(
                      images: images,
                      i: index,
                    ));
                  },
                  child: CachedNetworkImage(imageUrl: images![index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class AdvertDetailInfo extends StatelessWidget {
  const AdvertDetailInfo({
    Key? key,
    required this.advert,
  }) : super(key: key);

  final Advert advert;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Тема:".tr + "    ${advert.title}")),
              Icon(Icons.check, color: Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Дата:".tr + "    ${advert.data ?? " "}")),
              advert.data != ""
                  ? Icon(Icons.check, color: Colors.green)
                  : Icon(Icons.clear, color: Colors.red),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Аты:".tr + "   ${advert.user}")),
              Icon(Icons.check, color: Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Категория:".tr + "   ${advert.advertCategory ?? " "}")),
              advert.advertCategory != ""
                  ? Icon(Icons.check, color: Colors.green)
                  : Icon(Icons.clear, color: Colors.red),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Баасы:".tr + "   ${advert.price ?? " "}")),
              advert.price != ""
                  ? Icon(Icons.check, color: Colors.green)
                  : Icon(Icons.clear, color: Colors.red),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Адрес:".tr + "   ${advert.address ?? " "}")),
              advert.address != ""
                  ? Icon(Icons.check, color: Colors.green)
                  : Icon(Icons.clear, color: Colors.red),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Кыскача:".tr + "   ${advert.titleDescription ?? " "}",
                ),
              ),
              advert.titleDescription != ""
                  ? Icon(Icons.check, color: Colors.green)
                  : Icon(Icons.clear, color: Colors.red),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ReadMoreText(
                  "Толук маалымат:".tr + "   ${advert.descriptions}",
                  trimLines: 5,
                  style: TextStyle(),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Дагы оку'.tr,
                  trimExpandedText: 'Жабуу'.tr,
                  moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.check, color: Colors.green)
            ],
          ),
        ],
      ),
    );
  }
}

class AdvertConnect extends StatelessWidget {
  const AdvertConnect({
    Key? key,
    required this.advert,
  }) : super(key: key);

  final Advert advert;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          advert.phone != ""
              ? GestureDetector(
                  onTap: () {
                    UrlService().launchCaller(advert.phone);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Телефон:".tr),
                      Text("${advert.phone}"),
                      SvgPicture.asset(
                        "assets/icons/viber.svg",
                        width: 25,
                      )
                    ],
                  ),
                )
              : Container(),
          const SizedBox(height: 10),
          advert.whatsapp != ""
              ? GestureDetector(
                  onTap: () {
                    UrlService().launchWhatsApp(advert.whatsapp, "salam");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Whatsapp:".tr),
                      Text("${advert.whatsapp}"),
                      SvgPicture.asset(
                        "assets/icons/whatsapp.svg",
                        width: 25,
                      )
                    ],
                  ),
                )
              : Container(),
          const SizedBox(height: 10),
          advert.telegram != ""
              ? GestureDetector(
                  onTap: () {
                    UrlService().launchTelegram(advert.telegram);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Telegram:".tr),
                      Text("${advert.telegram}"),
                      SvgPicture.asset(
                        "assets/icons/telegram.svg",
                        width: 25,
                      )
                    ],
                  ),
                )
              : Container(),
          const SizedBox(height: 10),
          advert.email != ""
              ? GestureDetector(
                  onTap: () {
                    UrlService().launchEmail(advert.email);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("email address:".tr),
                      Text("${advert.email}"),
                      SvgPicture.asset(
                        "assets/icons/arroba.svg",
                        width: 25,
                      )
                    ],
                  ),
                )
              : Container(),
          const SizedBox(height: 10),
          advert.website != ""
              ? GestureDetector(
                  onTap: () {
                    UrlService().launchURL(advert.website);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Веб-сайт:'.tr + "   "),
                      Expanded(
                          child: Text(
                        "${advert.website}",
                        overflow: TextOverflow.ellipsis,
                      )),
                      SvgPicture.asset(
                        "assets/icons/globe-grid.svg",
                        width: 25,
                      ),
                    ],
                  ),
                )
              : Container(),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              ShareService().share(advert.descriptions, advert.title);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Болуш:".tr + "   "),
                Icon(Icons.publish_sharp),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
