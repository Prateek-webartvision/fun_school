// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_school/repo/chat_repo/chat_repo.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../repo/community/community_discussion_repo.dart';
import '../../router/app_router.dart';
import '../../style/assets.dart';
import '../../style/color.dart';
import '../../utils/app_utils.dart';
import '../chat_page/chat_page.dart';
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

class _SchoolCommunitiesPageState extends State<SchoolCommunitiesPage> {
  late CommunitiesTabController communitiesTabController;
  late CommunityDiscussionController discussionController;
  late CommunityGroupController groupController;
  late ChatUserController chatUserController;

  TextEditingController topic = TextEditingController();
  TextEditingController subject = TextEditingController();
  DetectableTextEditingController hashTagText = DetectableTextEditingController(
    regExp: hashTagRegExp,
    detectedStyle: TextStyle(
      color: Colors.blue,
      fontSize: 15,
    ),
  );
  SelectedImagesController selectedImagesController =
      SelectedImagesController();
  late Timer timer;
  @override
  void initState() {
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
          CommunitiesTabSelector(controller: communitiesTabController),
          Expanded(
            child: CommunitiesTabView(
              controller: communitiesTabController,
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
              child: SvgPicture.asset((controller.currentIndex == 2)
                  ? AppAssets.svg.groupFillIcon
                  : AppAssets.svg.pencilFillIcon),
              onPressed: () {
                if (controller.currentIndex == 0) {
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
                          final List<String> detections =
                              TextPatternDetector.extractDetections(
                            hashTagText.text,
                            hashTagRegExp,
                          );

                          rootNavigator.currentState!.pop();

                          AppUtils.showLoadingOverlay(() async {
                            try {
                              await CommunityDiscussionRepository
                                  .postTimeLineDiscussion(
                                hashTag: detections,
                                topic: topic.text,
                                subject: subject.text,
                                images: selectedImagesController.selectedImages,
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
                        },
                      );
                    },
                  );
                }

                if (controller.currentIndex == 2) {
                  //
                  showModalBottomSheet(
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
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "search",
                                  ),
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

class AllUsersController extends GetxController {
  ApiState? state;
  String? error;
  List<User> users = [];
  AllUsersController() {
    initLoad();
  }

  Future<void> initLoad() async {
    state = ApiState.loading;
    update();
    await _load();
  }

  Future<void> reLoad() async {
    await _load();
  }

  _load() async {
    try {
      users = await ChatRepository.getUsersList();
      state = ApiState.success;
    } catch (e) {
      error = e.toString();
      state = ApiState.error;
    }
    update();
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
