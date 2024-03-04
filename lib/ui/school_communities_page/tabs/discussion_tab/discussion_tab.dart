// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/repo/community/community_discussion_repo.dart';
import 'package:fun_school/style/color.dart';
import 'package:fun_school/ui/profile_page_other/other_profile_page.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:fun_school/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../router/app_router.dart';
import '../../../chat_page/chat_page.dart';
import '../../controllers/community_discussion_controller.dart';
import 'widgets/comment_sheet.dart';
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
                    // log(item.)

                    return DiscussionPostTile(
                      profileUrl: item.userProfileImage!,
                      userName: item.username!,
                      hashTag: item.hashtags?.first.hashtag,
                      onProfileClick: () {
                        //* others profile page
                        AppUtils.slidePush(
                            page: OtherProfilePage(userId: item.userId!));
                      },
                      likes: item.likesCount,
                      replies: item.replyCount,
                      onComment: () async {
                        //* comments
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
                      },
                      time: timeStampToDateTime(item.time!).toString(),
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
                      onOpenChat: () {
                        // open chat page with user name and profile
                        if (item.userId! == AppStorage.user.current!.userId) {
                          AppUtils.showSnack(
                              "You can't send message to yourself");
                        } else {
                          rootNavigator.currentState!.push(
                            MaterialPageRoute(
                              builder: (_) => ChatPage(
                                profileUrl: item.userProfileImage,
                                receiverID: item.userId!.toString(),
                                userName: item.username ?? "",
                              ),
                            ),
                          );
                        }
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
