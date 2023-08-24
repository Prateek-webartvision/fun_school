// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/ui/school_communities_page/tabs/discourssion_tab/discourssion_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'controllers/communities_tab_controller.dart';
import 'tabs/group_tab/group_tab.dart';
import 'widgets/communities_tab.dart';
import 'widgets/communities_tab_view.dart';
import 'widgets/new_post_sheet.dart';

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
                GroupsTab(),
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
                // post bottom sheet
                showModalBottomSheet(
                  context: rootNavigator.currentContext!,
                  isScrollControlled: true,
                  builder: (context) {
                    return NewPostSheet(
                        // onPostClick: () {},
                        );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
