import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/views/first/first2_screen.dart';

class First1Screen extends StatelessWidget {
  const First1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20),
          Container(
              child: Image.asset("assets/image/nookat_admin.jpeg")
          ),
          InkWell(
            onTap: (){
              Get.off(First2Screen());
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: MyColors.myRed,
              ),
              child: Text(
                "Далее",
                style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
