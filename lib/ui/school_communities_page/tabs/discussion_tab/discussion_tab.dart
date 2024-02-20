// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

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
//
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
                        final res = await AppUtils.showModelSheet(
                            child: CommentSheet(), isScrolled: true);
                        if (res == null || res.toString().isEmpty) {
                          log(res.toString(), name: "comment");
                        } else {
                          AppUtils.showLoadingOverlay(() async {
                            try {
                              await CommunityDiscussionRepository
                                  .commentDiscussion(
                                      discussionId:
                                          item.discussionId.toString(),
                                      comment: res);
                              await controller.reload();
                            } catch (e) {
                              log(e.toString(), name: "comment");
                            }
                          });
                          // log("done", name: "comment");
                        }
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
                                  discussionId: item.discussionId.toString());
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
  });

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: double.maxFinite),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      "Comment",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //
                    10.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: comment,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          hintText: "Write Comment",
                        ),
                        minLines: 1,
                        maxLines: 4,
                      ),
                    ),
                    10.height,
                    KBtn(
                        onClick: () {
                          appRoutes.pop(comment.text);
                        },
                        text: "Send")
                  ],
                ),
              ),
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
