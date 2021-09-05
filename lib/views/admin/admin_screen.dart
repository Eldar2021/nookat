import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/models/admin.dart';
import 'package:nookat/views/admin/ada_category_screen.dart';
import 'package:nookat/views/admin/add_admin_screen.dart';
import 'package:nookat/views/admin/add_advert_for_admin_screen.dart';
import 'package:nookat/views/admin/add_information_screen.dart';
import 'package:nookat/widgets/admin_widgets.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key, required this.admin}) : super(key: key);

  final Admin admin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(admin.name),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "${admin.name}",
                actions: [
                  Text("${admin.password}"),
                  Text("${admin.whatsapp}"),
                  Text("${admin.telegram}"),
                  Text("${admin.description}"),
                ],
                cancel: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Get.back();
                  },
                ),
              );
            },
            icon:const Icon(Icons.info_outline),
          )
        ],
      ),
      body: Column(
        children: [
          AdminMenu(
            colors: const[Colors.redAccent, Colors.deepPurpleAccent],
            text: "Жарнама беруу",
            function: () {
              Get.to(AddAdvertForAdminScreen());
            },
          ),
          AdminMenu(
            colors:const [Colors.deepPurple, Colors.yellowAccent],
            text: "Категория беруу",
            function: () {
              Get.to(AddCategoryScreen());
            },
          ),
          AdminMenu(
            colors: const[Colors.greenAccent, Colors.deepPurpleAccent],
            text: "Админ беруу",
            function: () {
              Get.to(AddAdminScreen());
            },
          ),
          AdminMenu(
            colors: const [Colors.red, Colors.blueAccent],
            text: "Маалымат берүү",
            function: () {
              Get.to(AddInformationScreen());
            },
          ),
        ],
      ),
    );
  }
}

