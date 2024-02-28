// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/repo/community/community_group_repo.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:fun_school/widgets/k_btn.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/chat_repo/chat_repo.dart';
import '../../../router/app_router.dart';
import '../../../style/color.dart';
import '../../../style/theme.dart';
import '../../school_communities_page/school_communities_page.dart';
import '../controller/all_user_controller.dart';
import '../controller/member_sheet_controller.dart';
import '../controller/school_communities_group_info_page.controller.dart';

class MembersSheet extends StatefulWidget {
  const MembersSheet({
    super.key,
    required this.controller,
  });

  final GroupInfoPageController controller;

  @override
  State<MembersSheet> createState() => _MembersSheetState();
}

class _MembersSheetState extends State<MembersSheet> {
  DraggableScrollableController scrollableController =
      DraggableScrollableController();
  SheetController sheetController = SheetController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: widget.controller,
      builder: (controller) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            if (notification.extent == notification.maxExtent) {
              sheetController.changeSage = true;
            } else {
              sheetController.changeSage = false;
            }
            return true;
          },
          child: DraggableScrollableSheet(
            controller: scrollableController,
            minChildSize: 0.5,
            maxChildSize: 1,
            initialChildSize: 0.5,
            expand: false,
            snap: true,
            snapSizes: [0.5, 1],
            shouldCloseOnMinExtent: false,
            builder: (context, scrollController) {
              return GetBuilder(
                init: sheetController,
                builder: (sheetCnt) {
                  return CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      if (sheetCnt.showSafe)
                        SliverToBoxAdapter(child: 40.height),
                      //* close bar
                      SliverToBoxAdapter(
                        child: Container(
                          height: 48,
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom:
                                  BorderSide(color: AppColor.softBorderColor),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Members",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                onTap: () {
                                  // rootNavigator.currentState!.pop();
                                  context.pop();
                                },
                                child: Icon(Icons.close_rounded),
                              )
                            ],
                          ),
                        ),
                      ),
                      // share group
                      SliverToBoxAdapter(
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              16.height,
                              Text(
                                "Ways to add people",
                                style: TextStyle(fontSize: 14),
                              ),
                              10.height,
                              // Add peoples
                              if (controller.groupInfo?.groupOwnerId ==
                                  AppStorage.user.current?.userId?.toString())
                                GestureDetector(
                                  onTap: () async {
                                    // add new member
                                    UserForChat? member =
                                        await showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero),
                                      isScrollControlled: true,
                                      useSafeArea: true,
                                      builder: (context) {
                                        return UsersList();
                                      },
                                    );
                                    // if member is not null
                                    // then add member
                                    if (member != null) {
                                      await CommunityGroupRepository
                                          .joinAndLeaveGroup(controller.groupID,
                                              userID: member.userId);
                                      await widget.controller.reLoad;
                                    }
                                  },
                                  child: Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: AppShadow.mainShadow,
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                              color: AppColor.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(32)),
                                          child: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        10.width,
                                        Expanded(
                                            child: Text("Add people",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                              if (controller.groupInfo?.groupOwnerId ==
                                  AppStorage.user.current?.userId?.toString())
                                8.height,
                              // share link
                              GestureDetector(
                                onTap: () async {
                                  final uri = Uri(
                                    scheme: "https",
                                    host: "funschool.com",
                                    path: "group",
                                    query: controller.groupInfo!.groupId!,
                                  );

                                  try {
                                    await Clipboard.setData(
                                        ClipboardData(text: uri.toString()));
                                    AppUtils.showSnack("Link Copied");
                                  } catch (e) {
                                    AppUtils.showSnack(e.toString());
                                  }
                                },
                                child: Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: AppShadow.mainShadow,
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                            color: AppColor.pinkColor,
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: Icon(
                                          Icons.link,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      10.width,
                                      Expanded(
                                          child: Text("Share a link",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // members
                      SliverToBoxAdapter(
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              10.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Members",
                                      style: TextStyle(fontSize: 14)),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: AppColor.mainColor,
                                      ),
                                      4.width,
                                      Text(
                                          "${controller.groupInfo?.groupMembers?.length}",
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ],
                              ),
                              10.height,
                            ],
                          ),
                        ),
                      ),

                      // members list
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverList.separated(
                          // itemCount: 10,
                          itemCount: controller.groupInfo!.groupMembers!.length,
                          itemBuilder: (context, index) {
                            final member =
                                controller.groupInfo!.groupMembers![index];
                            return ListTile(
                              dense: true,
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20),
                                  image: (member.profile != null)
                                      ? DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              member.profile!),
                                        )
                                      : null,
                                ),
                                child: (member.profile != null)
                                    ? null
                                    : Icon(Icons.person),
                              ),
                              title: Text(
                                // "Tanner Worthington",
                                member.memberUsername ?? "",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                (controller.groupInfo?.groupOwnerId ==
                                        member.memberId)
                                    ? "Admin"
                                    : "@${member.memberUsername}",
                                style: TextStyle(
                                    fontSize: 12, color: AppColor.mainColor),
                              ),
                              trailing: (sheetCnt.canShowPopup(
                                      controller: controller,
                                      currentMember: member.memberId))
                                  ? PopupMenuButton(
                                      icon: Icon(Icons.more_horiz),
                                      itemBuilder: (context) {
                                        return <PopupMenuEntry>[
                                          PopupMenuItem(
                                            value: 0,
                                            child: Text("Remove"),
                                          )
                                        ];
                                      },
                                      onSelected: (value) {
                                        if (value == 0) {
                                          AppUtils.showLoadingOverlay(() async {
                                            try {
                                              await CommunityGroupRepository
                                                  .removeMember(
                                                      groupId:
                                                          controller.groupID,
                                                      memberId:
                                                          member.memberId!);
                                              await widget.controller.reLoad;
                                            } catch (e) {
                                              AppUtils.showSnack(e.toString());
                                            }
                                          });
                                        }
                                      },
                                    )
                                  : null,
                            );
                          },
                          separatorBuilder: (context, index) => 10.height,
                        ),
                      ),
                      SliverToBoxAdapter(child: 10.height)
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late AllUsersController allUsersController;
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    allUsersController = AllUsersController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 1,
      minChildSize: 0.5,
      initialChildSize: 0.5,
      snap: true,
      shouldCloseOnMinExtent: false,
      controller: draggableScrollableController,
      builder: (context, scrollController) {
        return GetBuilder(
            init: allUsersController,
            builder: (controller) {
              if (controller.state == ApiState.loading) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.state == ApiState.error) {
                rootNavigator.currentState?.pop();
                AppUtils.showSnack(controller.error!);
                return SizedBox();
              }
              // on success
              return CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(child: 10.height),
                  //* search bar
                  SliverPersistentHeader(
                    delegate: SliverSearchDelegate(
                      minHeight: 50,
                      maxHeight: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              2.width,
                              Expanded(
                                child: TextField(
                                  controller: search,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "search",
                                  ),
                                  onChanged: (value) {
                                    controller.search(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    sliver: SliverList.separated(
                      itemCount: controller.users.length,
                      itemBuilder: (context, index) {
                        final user = controller.users[index];
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(100),
                                  image: (user.userProfileImage != null)
                                      ? DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              user.userProfileImage!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: (user.userProfileImage != null)
                                    ? null
                                    : Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                              ),
                              6.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.username ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      user.email ?? "",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              KBtn(
                                  onClick: () {
                                    context.pop<UserForChat>(user);
                                  },
                                  text: "Add"),
                              // Text("data")
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 10.height,
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}

  // onTap: () {
  //                           context.pop<UserForChat>(user);
  //                         },
