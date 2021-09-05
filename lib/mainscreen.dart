import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/controler/home_coltroller.dart';
import 'package:nookat/views/admin/admin_control_screen.dart';
import 'package:nookat/views/bottomScreens/add_advert_screen.dart';
import 'package:nookat/views/bottomScreens/homescreen.dart';
import 'package:nookat/views/bottomScreens/information_screen.dart';
import 'package:nookat/views/bottomScreens/news_screen.dart';
import 'package:nookat/views/bottomScreens/settings_screen.dart';
import 'package:nookat/views/category_detail.dart';
import 'package:nookat/views/contact_to_admin.dart';
import 'package:nookat/widgets/drawer_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HomeController controller = Get.put(HomeController());
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.handleScroll(_scrollController);
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  List<Widget> pages = [
    NewsScreen(),
    AddAdvertScreen(),
    InformationScreen(),
    SettingsScreen(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              child: new Image.asset(
                "assets/image/nookat_admin.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: MyColors.primaryColor,
              child: MyCategoryListStreamBuilder(
                function: (value) {
                  Get.to(CategoryDetailStream(category: '$value'));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              color: MyColors.myRed,
              child: GestureDetector(
                onTap: () {
                  Get.to(ContactToAdmin());
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: MyColors.whiteColor,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        "Администрация менен байланышуу".tr,
                        style: MyTextStyle.homeCategory,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              color: MyColors.primaryColor,
              child: GestureDetector(
                onTap: () {
                  Get.to(AdminControlScreen());
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.admin_panel_settings_outlined,
                      color: MyColors.whiteColor,
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Администрация".tr,
                      style: MyTextStyle.homeCategory,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap:()=> FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 7.0, right: 7.0, bottom: 70),
            child: Obx(() => pages[controller.page.value]),
          ),
        ),
      ),
      floatingActionButton: Obx(() {
        return Visibility(
          visible: controller.visible.value,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            onPressed: () {
              controller.backPage();
            },
            child: Icon(
              Icons.local_fire_department_sharp,
              color: MyColors.myRed,
              size: 60,
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () {
          return Visibility(
            visible: controller.visible.value,
            child: AnimatedBottomNavigationBar(
              icons: [
                Icons.article_outlined,
                Icons.add_circle_outline_outlined,
                Icons.device_unknown_sharp,
                Icons.settings,
              ],
              iconSize: 25,
              activeIndex: controller.page.value,
              leftCornerRadius: 5,
              rightCornerRadius: 5,
              gapLocation: GapLocation.center,
              backgroundColor: MyColors.primaryColor,
              activeColor: Colors.white,
              inactiveColor: MyColors.myRed,
              splashSpeedInMilliseconds: 400,
              splashColor: Colors.tealAccent,
              notchSmoothness: NotchSmoothness.defaultEdge,
              onTap: (index) {
                controller.changePage(index);
              },
            ),
          );
        },
      ),
    );
  }
}
