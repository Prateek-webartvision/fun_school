// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_school/repo/community/community_group_repo.dart';
import 'package:fun_school/widgets/k_btn.dart';
import 'package:fun_school/widgets/k_text_field.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../repo/community/community_discussion_repo.dart';
import '../../router/app_router.dart';
import '../../style/assets.dart';
import '../../style/color.dart';
import '../../utils/app_utils.dart';
import '../chat_page/chat_page.dart';
import '../school_communities_group_info_page/controller/all_user_controller.dart';
import 'controllers/chat_user_controller.dart';
import 'controllers/communities_tab_controller.dart';
import 'controllers/community_discussion_controller.dart';
import 'controllers/community_group_controller.dart';
import 'controllers/selected_image_controller.dart';
import 'tabs/chat_tab/chat_tab.dart';
import 'tabs/discussion_tab/discussion_tab.dart';
import 'tabs/group_tab/group_tab.dart';
import 'widgets/communities_tab.dart';
import 'widgets/communities_tab_view.dart';
import 'widgets/new_post_sheet.dart';

class SchoolCommunitiesPage extends StatefulWidget {
  const SchoolCommunitiesPage({super.key});

  @override
  State<SchoolCommunitiesPage> createState() => _SchoolCommunitiesPageState();
}

class _SchoolCommunitiesPageState extends State<SchoolCommunitiesPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  late CommunitiesTabController communitiesTabController;
  late CommunityDiscussionController discussionController;
  late CommunityGroupController groupController;
  late ChatUserController chatUserController;

  TextEditingController topic = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController hashTagText = TextEditingController();
  SelectedImagesController selectedImagesController =
      SelectedImagesController();
  late Timer timer;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    communitiesTabController = CommunitiesTabController(initIndex: 0);
    discussionController = CommunityDiscussionController();
    groupController = CommunityGroupController();
    chatUserController = ChatUserController();

    _taker();
    super.initState();
  }

  _taker() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      chatUserController.reLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // tab bar pages
          CommunitiesTabSelector(
            controller: communitiesTabController,
            tabController: tabController,
          ),

          Expanded(
            child: CommunitiesTabView(
              controller: communitiesTabController,
              tabController: tabController,
              children: [
                DiscussionTab(controller: discussionController),
                GroupsTab(controller: groupController),
                ChatTab(controller: chatUserController),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: AnimatedBuilder(
        animation: tabController,
        builder: (_, child) {
          return Visibility(
            // visible: controller.currentIndex != 1,
            visible: true,
            child: FloatingActionButton(
              mini: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(color: AppColor.white, width: 2),
              ),
              backgroundColor: AppColor.mainColor,
              child: (tabController.index != 2)
                  ? Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    )
                  : SvgPicture.asset(AppAssets.svg.groupFillIcon),
              // child: SvgPicture.asset(
              //   (controller.currentIndex == 2)
              //       ? AppAssets.svg.groupFillIcon
              //       : AppAssets.svg.pencilFillIcon,
              // ),
              onPressed: () async {
                // * Discussion Tap
                if (tabController.index == 0) {
                  //* post bottom sheet
                  showModalBottomSheet(
                    context: rootNavigator.currentContext!,
                    isScrollControlled: true,
                    builder: (context) {
                      //* Post bottom sheet
                      return NewPostSheet(
                        hashTag: hashTagText,
                        topic: topic,
                        subject: subject,
                        imagesController: selectedImagesController,
                        onFilePicker: () async {
                          final images = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: true,
                            allowCompression: true,
                          );
                          if (images != null) {
                            selectedImagesController.addImages(images.files);
                          }
                        },
                        onPostClick: () async {
                          if (hashTagText.text.isEmpty ||
                              topic.text.isEmpty ||
                              subject.text.isEmpty) {
                            AppUtils.showSnack("Enter all Fields");
                          } else {
                            rootNavigator.currentState!.pop();

                            AppUtils.showLoadingOverlay(() async {
                              try {
                                await CommunityDiscussionRepository
                                    .postTimeLineDiscussion(
                                  hashTag: hashTagText.text,
                                  topic: topic.text,
                                  subject: subject.text,
                                  images:
                                      selectedImagesController.selectedImages,
                                );
                                discussionController.reload();
                                AppUtils.showSnack("Post added successfully");
                              } catch (e) {
                                AppUtils.showSnack(e.toString());
                              }
                            });

                            // * clear all text
                            hashTagText.clear();
                            topic.clear();
                            subject.clear();
                          }
                        },
                      );
                    },
                  );
                }

                // * Group Tap
                if (tabController.index == 1) {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    // showDragHandle: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    builder: (context) {
                      return CreateGroupBottomSheet();
                    },
                  );
                  groupController.reLoad();
                }

                //* Message Tap
                if (tabController.index == 2) {
                  //
                  showModalBottomSheet(
                    // ignore: use_build_context_synchronously
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    showDragHandle: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    builder: (context) {
                      return UsersBottomSheet();
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    topic.dispose();
    subject.dispose();
    hashTagText.dispose();
    selectedImagesController.dispose();
    timer.cancel();
    super.dispose();
  }
}

class CreateGroupBottomSheet extends StatefulWidget {
  const CreateGroupBottomSheet({
    super.key,
  });

  @override
  State<CreateGroupBottomSheet> createState() => _CreateGroupBottomSheetState();
}

class _CreateGroupBottomSheetState extends State<CreateGroupBottomSheet> {
  TextEditingController groupName = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Create New Group",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          20.height,
          KTextField(
            controller: groupName,
            hint: "Group Name",
          ),
          10.height,
          KTextField(
            controller: description,
            hint: "Description",
          ),
          10.height,
          KBtn(
            width: double.maxFinite,
            onClick: () {
              if (groupName.text.isEmpty || description.text.isEmpty) {
                AppUtils.showSnack("Fill all details");
              } else {
                // create new Group
                AppUtils.showLoadingOverlay(() async {
                  try {
                    await CommunityGroupRepository.createNewGroup(
                        name: groupName.text.trim(),
                        des: description.text.trim());
                    appRoutes.pop();
                  } catch (e) {
                    AppUtils.showSnack("Fill all details");
                  }
                });
              }
            },
            text: "Create",
          )
        ],
      ),
    );
  }
}

class UsersBottomSheet extends StatefulWidget {
  const UsersBottomSheet({
    super.key,
  });

  @override
  State<UsersBottomSheet> createState() => _UsersBottomSheetState();
}

class _UsersBottomSheetState extends State<UsersBottomSheet> {
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
                        return GestureDetector(
                          onTap: () {
                            // log(user.toString());
                            // * send to chat page
                            rootNavigator.currentState!.push(
                              MaterialPageRoute(
                                builder: (_) => ChatPage(
                                  profileUrl: user.userProfileImage,
                                  receiverID: user.userId!,
                                  userName: user.username ?? "",
                                ),
                              ),
                            );
                          },
                          child: Container(
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
                                Column(
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
                              ],
                            ),
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

class SliverSearchDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double? minHeight;
  final double? maxHeight;

  SliverSearchDelegate({
    required this.child,
    this.minHeight = 40,
    this.maxHeight = 40,
  }) : assert(maxHeight! >= minHeight!);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => minHeight!;

  @override
  double get minExtent => maxHeight!;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
