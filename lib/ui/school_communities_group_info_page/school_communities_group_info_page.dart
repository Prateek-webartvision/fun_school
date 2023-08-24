// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/assets.dart';
import 'tabs/files_tab.dart';
import 'tabs/group_chat_tab.dart';
import 'tabs/meeting_tab.dart';

class SchoolCommunitiesGroupInfoPage extends StatefulWidget {
  const SchoolCommunitiesGroupInfoPage({super.key});

  @override
  State<SchoolCommunitiesGroupInfoPage> createState() => _SchoolCommunitiesGroupInfoPageState();
}

class _SchoolCommunitiesGroupInfoPageState extends State<SchoolCommunitiesGroupInfoPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border(
                bottom: BorderSide(color: AppColor.softBorderColor),
              ),
            ),
            padding: EdgeInsets.all(12),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1692317787245-366c18a2ae2e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    12.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Physics Enthusiasts",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Dive into the world of physics, from quantum mechanics to classical dynamics.",
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          4.height,
                          Row(children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(AppAssets.svg.parentFillIcon),
                                4.width,
                                Text(
                                  "1200",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            10.width,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(AppAssets.svg.calendarlineIcon),
                                4.width,
                                Text(
                                  "Joined on May 20, 2023",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
                12.height,
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColor.softBorderColor),
                    color: AppColor.white,
                  ),
                  alignment: Alignment.center,
                  child: Text("Joined"),
                ),
              ],
            ),
          ),
          //
          Container(
            color: AppColor.white,
            child: TabBar(
              controller: tabController,
              tabs: [
                Tab(text: "Chat Room"),
                Tab(text: "Meetings"),
                Tab(text: "Files"),
              ],
            ),
          ),
          // tab body
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                GroupChatRoomTab(),
                MeetingsTab(),
                FilesTab(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
