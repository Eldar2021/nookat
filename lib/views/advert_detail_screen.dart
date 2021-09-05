import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/models/advert.dart';
import 'package:nookat/widgets/advert_detail_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AdvertDetailScreen extends StatelessWidget {
  const AdvertDetailScreen({Key? key, required this.advert}) : super(key: key);

  final Advert advert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              advert.photos!.isEmpty
                  ? Container(
                      width: Get.width,
                      height: Get.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage("assets/image/nookat.jpeg"),
                            fit: BoxFit.cover,
                          )),
                    )
                  : AdvertImages(images: advert.photos),
              AdvertDetailInfo(advert: advert),
              AdvertConnect(advert: advert),
              advert.youtube != ""
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: "${advert.youtube}",
                          flags: YoutubePlayerFlags(
                            controlsVisibleAtStart: false,
                            autoPlay: false,
                            mute: false,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
