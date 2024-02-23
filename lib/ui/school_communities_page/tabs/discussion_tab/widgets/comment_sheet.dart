// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_school/style/assets.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../../models/community_discussion_model/community_discussion_model.dart';
import '../../../../../repo/community/community_discussion_repo.dart';
import '../../../../../utils/app_utils.dart';
import '../../../controllers/community_discussion_controller.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({
    super.key,
    required this.controller,
    required this.discussion,
  });
  final CommunityDiscussionController controller;
  final CommunityDiscussionModel discussion;

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  TextEditingController comment = TextEditingController();
  late CommunityDiscussionModel discussion;
  PlatformFile? selectedImage;

  @override
  void initState() {
    _updateDis();
    super.initState();
  }

  _updateDis() {
    discussion = widget.controller.discussions!
        .where((element) =>
            element.discussionId! == widget.discussion.discussionId!)
        .first;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: widget.controller,
      builder: (controller) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.5,
          maxChildSize: 1,
          expand: false,
          snap: true,
          shouldCloseOnMinExtent: false,
          snapSizes: [0.5, 1],
          builder: (_, scrollController) => Column(
            children: [
              Icon(
                Icons.remove,
                color: Colors.grey[600],
              ),
              Text(
                "Comments ${(discussion.replyCount! > 0) ? discussion.replyCount : ""}"
                    .toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // comments List
              Expanded(
                child: ListView.separated(
                  // reverse: true,
                  controller: scrollController,
                  itemCount: discussion.replies?.length ?? 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemBuilder: (_, index) {
                    final reply = discussion.replies![index];

                    // log(reply.medias.toString());
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey[300],
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  reply.userProfileImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        6.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "Name",
                                reply.userName ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (reply.text != null && reply.text!.isNotEmpty)
                                Text(
                                  // "Comments",
                                  reply.text ?? "f",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (reply.medias?.first.src != null) 4.height,
                              if (reply.medias?.first.src != null)
                                Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image(
                                    image: CachedNetworkImageProvider(
                                        reply.medias!.first.src!),
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
              ),
              // 3
              Container(
                // height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    if (selectedImage != null)
                      Image(
                        image: FileImage(File(selectedImage!.path!)),
                        height: 100,
                      ),
                    Row(
                      children: [
                        // Image Picker
                        GestureDetector(
                          onTap: () async {
                            final res = await FilePicker.platform.pickFiles(
                              type: FileType.image,
                              allowCompression: true,
                              allowMultiple: false,
                            );

                            final images = res?.files;
                            if (images != null && images.isNotEmpty) {
                              selectedImage = images.first;
                              setState(() {});
                            }
                          },
                          child: SvgPicture.asset(
                            AppAssets.svg.attachment2Icon,
                            height: 28,
                            width: 28,
                            color: Colors.black54,
                          ),
                        ),
                        8.width,
                        // comment Text
                        Expanded(
                          child: TextField(
                            controller: comment,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Comment",
                              hintStyle: TextStyle(color: Colors.black45),
                            ),
                          ),
                        ),
                        // send btn
                        GestureDetector(
                          onTap: () {
                            // AppUtils.showSnack("message");
                            AppUtils.showLoadingOverlay(() async {
                              try {
                                await CommunityDiscussionRepository
                                    .commentDiscussion(
                                  discussionId:
                                      discussion.discussionId.toString(),
                                  comment: comment.text.trim(),
                                  image: selectedImage,
                                );

                                await controller.reload();
                                setState(() {
                                  _updateDis();
                                  selectedImage = null;
                                  comment.clear();
                                });
                                // appRoutes.pop();
                                AppUtils.showSnack("Reply added successfully");
                              } catch (e) {
                                log(e.toString(), name: "comment");
                              }
                            });
                          },
                          child: Icon(Icons.send),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
