// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:fun_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:fun_school/widgets/error_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../repo/community/community_group_repo.dart';
import '../../style/assets.dart';
import 'controller/group_messages.controller.dart';
import 'controller/school_communities_group_info_page.controller.dart';
import 'tabs/files_tab.dart';
import 'tabs/group_chat_tab.dart';
import 'tabs/meeting_tab.dart';
import 'widgets/members_sheet.dart';

class CommunitiesGroupInfoPage extends StatefulWidget {
  const CommunitiesGroupInfoPage({
    super.key,
    required this.groupId,
  });
  final String groupId;

  @override
  State<CommunitiesGroupInfoPage> createState() =>
      _CommunitiesGroupInfoPageState();
}

class _CommunitiesGroupInfoPageState extends State<CommunitiesGroupInfoPage>
    with TickerProviderStateMixin {
  //
  late TabController tabController;
  late GroupInfoPageController infoPageController;
  late GroupMessageController groupMessageController;

  Timer? timer;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    infoPageController = GroupInfoPageController(widget.groupId);
    groupMessageController = GroupMessageController(widget.groupId);
    _timeTicker();
    super.initState();
  }

  _timeTicker() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      await groupMessageController.reLoad;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        actions: [
          IconButton(
            onPressed: () {
              // add more members sheet
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                builder: (_) {
                  return MembersSheet(
                    controller: infoPageController,
                  );
                },
                isScrollControlled: true,
              );
            },
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: GetBuilder(
          init: infoPageController,
          builder: (controller) {
            // on loading
            if (controller.state == ApiState.loading) {
              return Center(child: CircularProgressIndicator());
            }

            // on error
            if (controller.state == ApiState.error) {
              return ErrorPage(
                error: controller.error,
                onError: () {
                  controller.initLoad;
                },
              );
            }

            // on success
            GroupMember? canIMember =
                controller.getMember(controller.groupInfo);

            return Column(
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
                                  // "Physics Enthusiasts",
                                  controller.groupInfo?.groupName ?? "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  // "Dive into the world of physics, from quantum mechanics to classical dynamics.",
                                  controller.groupInfo?.description ?? "",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                4.height,
                                Row(children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                          AppAssets.svg.parentFillIcon),
                                      4.width,
                                      Text(
                                        // "1200",
                                        controller.groupInfo?.totalMembers ??
                                            "0",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  10.width,
                                  if (canIMember != null)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                            AppAssets.svg.calendarlineIcon),
                                        4.width,
                                        Text(
                                          // May 20, 2023
                                          "Joined on ${DateFormat("MMM d, yyyy").format(timeStampToDateTime(canIMember.dateJoined))}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
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
                      // join / leave btn
                      GestureDetector(
                        onTap: () {
                          // join and leave group
                          AppUtils.showLoadingOverlay(() async {
                            try {
                              await CommunityGroupRepository.joinAndLeaveGroup(
                                  controller.groupInfo!.groupId!);
                              await controller.reLoad;
                            } catch (e) {
                              AppUtils.showSnack(e.toString());
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: (canIMember != null)
                                    ? Colors.red
                                    : AppColor.softBorderColor),
                            color: AppColor.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            (canIMember != null) ? "Leave Group" : "Join Group",
                            style: TextStyle(
                              color: (canIMember != null)
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // group chats
                if (canIMember != null)
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
                if (canIMember != null)
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        GroupChatRoomTab(controller: groupMessageController),
                        MeetingsTab(),
                        FilesTab(),
                      ],
                    ),
                  )
              ],
            );
          }),
    );
  }
}
