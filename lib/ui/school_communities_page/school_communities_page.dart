// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/ui/school_communities_page/tabs/discourssion_tab/discourssion_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import 'controllers/communities_tab_controller.dart';
import 'widgets/communities_tab.dart';
import 'widgets/communities_tab_view.dart';
import 'widgets/group_tab_tile.dart';
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

class GroupsTab extends StatelessWidget {
  const GroupsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12, bottom: 10),
          sliver: SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Groups",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.height,
                Text(
                  "Groups are specialized communities tailored to specific courses, topics, or interests.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.separated(
            itemCount: 3,
            itemBuilder: (context, index) {
              return GroupTabTile(
                onItemClick: () {
                  print("object");
                },
              );
            },
            separatorBuilder: (context, index) => 10.height,
          ),
        )
      ],
    );
  }
}
