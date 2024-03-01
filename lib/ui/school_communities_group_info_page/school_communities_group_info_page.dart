// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:fun_school/widgets/error_page.dart';
import 'package:fun_school/widgets/k_btn.dart';
import 'package:fun_school/widgets/k_text_field.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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
  late GroupMeetingController groupMeetingController;
  late GroupFilesController groupFilesController;

  Timer? timer;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    infoPageController = Get.put(GroupInfoPageController(widget.groupId),
        tag: widget.groupId, permanent: true);

    groupMessageController = Get.put(GroupMessageController(widget.groupId),
        tag: widget.groupId, permanent: true);

    groupMeetingController = Get.put(GroupMeetingController(widget.groupId),
        tag: widget.groupId, permanent: true);

    groupFilesController = Get.put(GroupFilesController(widget.groupId),
        tag: widget.groupId, permanent: true);
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
                backgroundColor: Colors.white,
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
                                            AppAssets.svg.calendarLineIcon),
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
                        MeetingsTab(controller: groupMeetingController),
                        FilesTab(controller: groupFilesController),
                      ],
                    ),
                  )
              ],
            );
          }),
      floatingActionButton: AnimatedBuilder(
          animation: tabController,
          builder: (context, child) {
            // log(tabController.indexIsChanging.toString());

            return Visibility(
              visible: (tabController.index == 1),
              child: FloatingActionButton(
                mini: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: AppColor.white, width: 2),
                ),
                backgroundColor: AppColor.mainColor,
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  AppUtils.showModelSheet(
                    child: CreateMeetingSheet(groupID: widget.groupId),
                    shape: BeveledRectangleBorder(),
                    isScrolled: true,
                  );
                  // showBottomSheet(
                  //   context: context,

                  //   builder: (context) {
                  //     return CreateMeetingSheet();
                  //   },
                  // );
                  // showModalBottomSheet(
                  //   context: context,
                  //   isScrollControlled: true,
                  //   builder: (context) {
                  //     return CreateMeetingSheet();
                  //   },
                  // );
                },
              ),
            );
          }),
    );
  }
}

class CreateMeetingSheet extends StatefulWidget {
  const CreateMeetingSheet({
    super.key,
    required this.groupID,
  });
  final String groupID;

  @override
  State<CreateMeetingSheet> createState() => _CreateMeetingSheetState();
}

class _CreateMeetingSheetState extends State<CreateMeetingSheet> {
  final TextEditingController title = TextEditingController();
  final TextEditingController des = TextEditingController();
  final TextEditingController link = TextEditingController();
  final TextEditingController duration = TextEditingController();
  final TextEditingController date = TextEditingController();
  DateTime? selectedDate;
  final TextEditingController time = TextEditingController();
  TimeOfDay? selectedTime;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: double.maxFinite,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin:
            EdgeInsets.only(bottom: (MediaQuery.of(context).viewInsets.bottom)),
        child: ListView(
          shrinkWrap: true,
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Create New Meeting",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(Icons.close),
                )
              ],
            ),
            //
            20.height,
            KTextField(
              hint: "Title",
              controller: title,
            ),
            10.height,
            KTextField(
              hint: "Description",
              controller: des,
            ),
            10.height,
            KTextField(
              hint: "Meeting Link",
              controller: link,
            ),
            10.height,
            KTextField(
              hint: "Duration in Min",
              controller: duration,
              textInputType: TextInputType.number,
            ),
            10.height,
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    Duration(days: 30),
                  ),
                );
                if (date != null) {
                  // log(date.toString());
                  selectedDate = date;
                  this.date.text =
                      DateFormat("MMM dd, yyyy").format(selectedDate!);
                }
              },
              child: KTextField(
                hint: "Meeting Date",
                enabled: false,
                controller: date,
              ),
            ),
            10.height,
            InkWell(
              onTap: () async {
                selectedTime = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());

                time.text = TimeOfDay(
                  hour: selectedTime!.hour,
                  minute: selectedTime!.minute,
                  // ignore: use_build_context_synchronously
                ).format(context);
              },
              child: KTextField(
                hint: "Meeting Time",
                enabled: false,
                controller: time,
              ),
            ),
            if (errorMessage.isNotEmpty) 10.height,
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            20.height,
            KBtn(
              onClick: () async {
                if (title.text.isEmpty ||
                    des.text.isEmpty ||
                    date.text.isEmpty ||
                    time.text.isEmpty ||
                    duration.text.isEmpty ||
                    link.text.isEmpty) {
                  setState(() {
                    errorMessage = "Enter All Fields";
                  });
                  Future.delayed(
                    Duration(seconds: 2),
                    () {
                      setState(() {
                        errorMessage = "";
                      });
                    },
                  );
                } else {
                  final String hostId =
                      AppStorage.user.current?.userId?.toString() ?? "";

                  AppUtils.showLoadingOverlay(() async {
                    try {
                      await CommunityGroupRepository.createGroupMeeting(
                        title: title.text.trim(),
                        des: des.text.trim(),
                        meetingDate: selectedDate!,
                        meetingTime: selectedTime!,
                        duration: duration.text.trim(),
                        hostName: hostId,
                        link: link.text.trim(),
                        groupID: widget.groupID,
                      );
                      await Get.find<GroupMeetingController>().reLoad;
                      // ignore: use_build_context_synchronously
                      context.pop();
                    } catch (e) {
                      setState(() {
                        errorMessage = e.toString();
                      });
                      // AppUtils.showSnack(e.toString());
                    }
                  });
                }
              },
              text: "Create Meeting",
            )
          ],
        ),
      );
    });
  }
}

class GroupMeetingController extends GetxController {
  ApiState? state;
  String? error;
  List<GroupMeetingModel> meetings = [];
  final String groupID;

  GroupMeetingController(this.groupID) {
    initLoad;
  }

  Future<void> get initLoad async {
    state = ApiState.loading;
    update();
    await _load();
  }

  Future<void> get reLoad async {
    await _load();
  }

  _load() async {
    try {
      meetings = await CommunityGroupRepository.getGroupMeetings(groupID);
      state = ApiState.success;
      // log(res.toString());
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }
    update();
  }
}

class GroupFilesController extends GetxController {
  ApiState? state;
  String? error;
  List<GroupFileModel> files = [];
  final String groupID;

  GroupFilesController(this.groupID) {
    initLoad;
  }
  //

  Future<void> get initLoad async {
    state = ApiState.loading;
    update();
    await _load();
  }

  Future<void> get reLoad async {
    await _load();
  }

  _load() async {
    try {
      files = await CommunityGroupRepository.getGroupFiles(groupID);
      state = ApiState.success;
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }

    update();
  }
}
