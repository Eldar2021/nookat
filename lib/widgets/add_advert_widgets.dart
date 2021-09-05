import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:readmore/readmore.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    required this.textEditingController,
    required this.text,
    this.valid = false,
    this.info,
    this.maxLines = 1,
  });

  final TextEditingController textEditingController;
  final String text;
  final bool valid;
  final String? info;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(text, style: const TextStyle(fontSize: 20),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            maxLines: maxLines,
            controller: textEditingController,
            validator: (value) {
              if (valid == true) {
                if (value!.isEmpty) {
                  return "text is empty";
                } else {
                  return null;
                }
              } else {
                return null;
              }
            },
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              labelText: text,
              hintText: text,
            ),
          ),
        ),
        info != null ? Padding(
          padding:const EdgeInsets.all(8.0),
          child:  ReadMoreText(
            info!,
            trimLines: 1,
            style: TextStyle(),
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Дагы оку'.tr,
            trimExpandedText: 'Жабуу'.tr,
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ): Container(),
      ],
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.image,
    required this.function,
  }) : super(key: key);

  final String image;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        width: Get.width / 3.3,
        height: Get.width / 3.3,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          border: Border.all(),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
