import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({
    Key? key,
    required this.images,
    this.i = 0,
  }) : super(key: key);

  final List<dynamic>? images;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: PhotoViewGallery.builder(
          itemCount: images!.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                images![index],
              ),
              minScale: PhotoViewComputedScale.contained * 0.9,
              maxScale: PhotoViewComputedScale.covered * 3,
            );
          },
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

