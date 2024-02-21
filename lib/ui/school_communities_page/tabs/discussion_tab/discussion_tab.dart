// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fun_school/main.dart';
import 'package:fun_school/network/url/app_urls.dart';
import 'package:fun_school/repo/community/community_discussion_repo.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/style/color.dart';
import 'package:fun_school/ui/profile_page_other/other_profile_page.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:fun_school/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:fun_school/widgets/k_btn.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../models/community_discussion_model/community_discussion_model.dart';
import '../../controllers/community_discussion_controller.dart';
import 'widgets/text_post_tile.dart';

class DiscussionTab extends StatefulWidget {
  const DiscussionTab({
    super.key,
    required this.controller,
  });
  final CommunityDiscussionController controller;

  @override
  State<DiscussionTab> createState() => _DiscussionTabState();
}

class _DiscussionTabState extends State<DiscussionTab> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: widget.controller,
      builder: (controller) {
        //* loading
        if (controller.state == ApiState.loading) {
          return Center(child: CircularProgressIndicator());
        }

        //* error
        if (controller.state == ApiState.error) {
          return ErrorPage(
              error: controller.error.toString(),
              onError: () {
                controller.initLoad();
              });
        }

        //* success
        return RefreshIndicator(
          onRefresh: () async {
            await controller.reload();
          },
          child: CustomScrollView(
            slivers: [
              //* trending
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 12).copyWith(top: 15),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Trending",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.6,
                        ),
                      ),
                      12.height,
                      SizedBox(
                        height: 34,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller.trendingHashTags!.length,
                          itemBuilder: (context, index) {
                            final item = controller.trendingHashTags![index];
                            return TrendingHashtagChip(
                              text: item.hashtag!,
                              isSelected:
                                  item.hashtag == controller.selectedTag,
                              onTap: () {
                                controller.setSelectTag = item.hashtag!;
                              },
                            );
                          },
                          separatorBuilder: (context, index) => 4.width,
                        ),
                      ),
                      15.height,
                    ],
                  ),
                ),
              ),

              //* posts
              if (controller.discussions!.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Center(
                      child: Text(
                        "No Discussion to show please reload or change hashtag",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              else
                SliverList.separated(
                  itemCount: controller.discussions!.length,
                  itemBuilder: (context, index) {
                    final item = controller.discussions![index];

                    return DiscussionPostTile(
                      profileUrl: item.userProfileImage!,
                      userName: item.username!,
                      onProfileClick: () {
                        //* others profile page
                        AppUtils.slidePush(
                            page: OtherProfilePage(userId: item.userId!));
                      },
                      likes: item.likesCount,
                      replies: item.replyCount,
                      onComment: () async {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (context) {
                              return CommentSheet(
                                controller: controller,
                                discussion: item,
                              );
                            });

                        // final res = await AppUtils.showModelSheet(
                        //     child: CommentSheet(), isScrolled: true);
                        // if (res == null || res.toString().isEmpty) {
                        //   log(res.toString(), name: "comment");
                        // } else {
                        //   AppUtils.showLoadingOverlay(() async {
                        //     try {
                        //       await CommunityDiscussionRepository
                        //           .commentDiscussion(
                        //         discussionId: item.discussionId.toString(),
                        //         comment: res,
                        //       );
                        //       await controller.reload();
                        //       AppUtils.showSnack("Reply added successfully");
                        //     } catch (e) {
                        //       log(e.toString(), name: "comment");
                        //     }
                        //   });
                        // }
                      },
                      time: DateTime.fromMicrosecondsSinceEpoch(
                              int.parse(item.time!) * 1000000)
                          .toUtc()
                          .toString(),
                      type: item.type!,
                      userType: item.userType!,
                      isVerify: item.userType == "Certified_Tutor",
                      topic: item.topic ?? "",
                      message: item.text!,
                      media: item.media,
                      first2Likes: item.likes,
                      isLiked: item.isLiked,
                      onLikeClick: () {
                        AppUtils.showLoadingOverlay(() async {
                          await CommunityDiscussionRepository
                              .likeDislikeDiscussion(
                            discussionId: item.discussionId.toString(),
                          );
                          controller.setLikeDisLike(discussion: item);
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Divider(height: 0),
                )
            ],
          ),
        );
      },
    );
  }
}

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
          initialChildSize: 1,
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
                "Comment ${(discussion.replyCount! > 0) ? discussion.replyCount : ""}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: discussion.replies?.length ?? 0,
                  itemBuilder: (_, index) {
                    final reply = discussion.replies![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
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
                                Text(
                                  // "Comments",
                                  reply.text ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
              ),
              Container(
                // height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
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
                              );

                              await controller.reload();
                              setState(() {
                                _updateDis();
                                comment.clear();
                              });
                              // appRoutes.pop();
                              AppUtils.showSnack("Reply added successfully");
                            } catch (e) {
                              log(e.toString(), name: "comment");
                            }
                          });
                        },
                        child: Icon(Icons.send))
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

class TrendingHashtagChip extends StatelessWidget {
  const TrendingHashtagChip({
    super.key,
    required this.text,
    this.onTap,
    this.isSelected = false,
  });
  final String text;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: isSelected ? AppColor.mainColor : AppColor.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColor.softBorderColor),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColor.white : AppColor.tegTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
