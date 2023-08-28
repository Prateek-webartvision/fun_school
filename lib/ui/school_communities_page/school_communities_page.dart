// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/ui/chat_page/chat_page.dart';
import 'package:citycloud_school/ui/school_communities_page/tabs/discourssion_tab/discourssion_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

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
                ChatTab(),
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
            visible: controller.currentIndex != 1,
            child: FloatingActionButton(
              mini: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(color: AppColor.white, width: 2),
              ),
              backgroundColor: AppColor.mainColor,
              child: SvgPicture.asset((controller.currentIndex == 2) ? AppAssets.svg.groupFillIcon : AppAssets.svg.pencilFillIcon),
              onPressed: () {
                if (controller.currentIndex == 0) {
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
                }

                if (controller.currentIndex == 2) {
                  print("chat");
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class ChatTab extends StatelessWidget {
  const ChatTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.softBorderColor),
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              SvgPicture.asset(AppAssets.svg.search),
              8.width,
              Text(
                "Search Messages",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
        17.height,
        ListView.separated(
          shrinkWrap: true,
          itemCount: 3,
          primary: false,
          itemBuilder: (context, index) {
            return ChatUserTile(
              onTap: () {
                // print("object");
                rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => ChatPage()));
                // Get.to(() => ChatPage());
              },
            );
          },
          separatorBuilder: (_, __) => 17.height,
        ),
      ],
    );
  }
}

class ChatUserTile extends StatelessWidget {
  const ChatUserTile({
    super.key,
    required this.onTap,
  });
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColor.softBorderColor,
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tutor Tina",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "10:10 PM",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  "Thanks for the resource links! They were super helpful.",
                  style: TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
