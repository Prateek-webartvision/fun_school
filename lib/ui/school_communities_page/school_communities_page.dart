// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/ui/school_communities_page/tabs/discourssion_tab/discourssion_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'controllers/communities_tab_controller.dart';
import 'widgets/communities_tab.dart';
import 'widgets/communities_tab_view.dart';

class SchoolCommunitiesPage extends StatefulWidget {
  const SchoolCommunitiesPage({super.key});

  @override
  State<SchoolCommunitiesPage> createState() => _SchoolCommunitiesPageState();
}

class _SchoolCommunitiesPageState extends State<SchoolCommunitiesPage> {
  late CommunitiesTabController communitiesTabController;

  @override
  void initState() {
    communitiesTabController = CommunitiesTabController(initIntex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommunitiesTabSelector(controller: communitiesTabController),
          Expanded(
            child: CommunitiesTabView(
              controller: communitiesTabController,
              children: [
                DiscourssionTab(),
                Center(child: Text("data 2")),
                Center(child: Text("data 3")),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: GetBuilder(
        init: communitiesTabController,
        builder: (controller) {
          return Visibility(
            visible: controller.currentIndex == 0,
            child: FloatingActionButton(
              mini: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(color: AppColor.white, width: 2),
              ),
              backgroundColor: AppColor.mainColor,
              child: SvgPicture.asset(AppAssets.svg.pencilFillIcon),
              onPressed: () {
                //
                showModalBottomSheet(
                  context: rootNavigator.currentContext!,
                  isScrollControlled: true,
                  builder: (context) {
                    return NewPostSheet();
                  },
                );

                // rootNavigator.currentState!.toString();
              },
            ),
          );
        },
      ),
    );
  }
}

class NewPostSheet extends StatefulWidget {
  const NewPostSheet({
    super.key,
  });

  @override
  State<NewPostSheet> createState() => _NewPostSheetState();
}

class _NewPostSheetState extends State<NewPostSheet> {
  bool isPage2 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: AppColor.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: AppColor.softBorderColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Post Discussion",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    rootNavigator.currentState!.pop();
                  },
                  child: Icon(Icons.close_rounded),
                )
              ],
            ),
          ),
          //
          Text("data"),
          ElevatedButton(
              onPressed: () {
                isPage2 = true;
                setState(() {});
              },
              child: Text("NextShet"))
        ],
      ),
    );
  }

  Widget page1() => Container(
        height: 100,
        width: double.maxFinite,
        color: AppColor.white,
        child: Column(
          children: [
            Text("data"),
            ElevatedButton(
                onPressed: () {
                  isPage2 = true;
                  setState(() {});
                },
                child: Text("NextShet"))
          ],
        ),
      );

  Widget page2 = Container(
    height: 100,
    width: double.maxFinite,
    color: AppColor.facebookBlue,
    child: Column(
      children: [Text("data"), ElevatedButton(onPressed: () {}, child: Text("NextShet"))],
    ),
  );
}
