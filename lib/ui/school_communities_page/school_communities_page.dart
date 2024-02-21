// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fun_school/repo/community/community_discussion_repo.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/style/assets.dart';
import 'package:fun_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_school/ui/school_communities_page/controllers/chat_user_controller.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:get/get.dart';

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

  @override
  void initState() {
    communitiesTabController = CommunitiesTabController(initIndex: 0);
    discussionController = CommunityDiscussionController();
    groupController = CommunityGroupController();
    chatUserController = ChatUserController();
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
                  debugPrint("chat");
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
    super.dispose();
  }
}
