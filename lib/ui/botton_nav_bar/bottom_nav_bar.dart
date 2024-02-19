// ignore_for_file: prefer_const_constructors

import 'package:fun_school/style/assets.dart';
import 'package:fun_school/style/color.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';

import 'controller/nav_page_controller.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key, required this.child});
  final Widget child;

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  late NavPageController navPageController;
  Color appbarBg = AppColor.scaffoldBg;

  @override
  void initState() {
    Get.lazyPut(() => NavPageController());
    navPageController = Get.find<NavPageController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBg,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: GetBuilder(
          init: navPageController,
          builder: (controller) {
            return AppBar(
              backgroundColor: appbarBg,
              leading: Center(
                child: Image.asset(AppAssets.logo, height: 40, width: 40),
              ),
              title: (controller.currentIndex == 3)
                  ? Text(
                      "Communities",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    )
                  : null,
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    AppUtils.showSnack("coming soon");
                  },
                  icon: Icon(Icons.notifications_outlined),
                ),
              ],
            );
          },
        ),
      ),
      // body
      body: widget.child,
      // nav bar
      bottomNavigationBar: GetBuilder(
        init: navPageController,
        builder: (controller) {
          return SnakeNavigationBar.color(
            selectedItemColor: Theme.of(context).colorScheme.primary,
            snakeViewColor: Theme.of(context).colorScheme.primary,
            snakeShape: SnakeShape(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)),
                height: 3,
                centered: false),
            backgroundColor: AppColor.white,
            selectedLabelStyle: TextStyle(fontSize: 10),
            unselectedLabelStyle: TextStyle(fontSize: 10),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: controller.currentIndex,
            onTap: (index) => controller.updatePage(index: index),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.book_outlined),
                  activeIcon: Icon(Icons.book_rounded),
                  label: "Study"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.edit_outlined),
                  activeIcon: Icon(Icons.edit_rounded),
                  label: "Exam"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.group_outlined),
                  activeIcon: Icon(Icons.group_rounded),
                  label: "Community"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_outlined),
                  activeIcon: Icon(Icons.list_rounded),
                  label: "Settings"),
            ],
          );
        },
      ),
    );
  }
}
