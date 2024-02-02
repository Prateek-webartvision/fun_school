// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/repo/community/community_discussion_repo.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/ui/profile_page_other/other_profile_page.dart';
import 'package:citycloud_school/utils/app_utils.dart';
import 'package:citycloud_school/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../controllers/community_discussion_controller.dart';
import 'wigets/text_post_tile.dart';

class DiscourssionTab extends StatefulWidget {
  const DiscourssionTab({
    super.key,
    required this.controller,
  });
  final CommunityDiscussionController controller;

  @override
  State<DiscourssionTab> createState() => _DiscourssionTabState();
}

class _DiscourssionTabState extends State<DiscourssionTab> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: widget.controller,
      builder: (controller) {
        // loading
        if (controller.state == ApiState.loading) {
          return Center(child: CircularProgressIndicator());
        }
        // error

        if (controller.state == ApiState.error) {
          return ErrorPage(
              error: controller.error.toString(),
              onError: () {
                controller.iniLoad();
              });
        }

        // sucess
        // pull to refress

        return RefreshIndicator(
          onRefresh: () async {
            await controller.reload();
          },
          child: CustomScrollView(
            slivers: [
              // tranding
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 12).copyWith(top: 15),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trending",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 1.6,
                            ),
                          ),
                          // Text(
                          //   "See All",
                          //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.mainColor),
                          // )
                        ],
                      ),
                      12.height,
                      SizedBox(
                        height: 34,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller.trendingHastags!.length,
                          itemBuilder: (context, index) {
                            final item = controller.trendingHastags![index];
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
                      // SizedBox(
                      //   height: 34,
                      //   child: ListView(
                      //     scrollDirection: Axis.horizontal,
                      //     shrinkWrap: true,
                      //     children: [
                      //       Container(
                      //         height: double.maxFinite,
                      //         decoration: BoxDecoration(
                      //           color: AppColor.white,
                      //           borderRadius: BorderRadius.circular(100),
                      //           border: Border.all(color: AppColor.softBorderColor),
                      //         ),
                      //         alignment: Alignment.center,
                      //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      //         child: Text(
                      //           "Mars Colonization",
                      //           style: TextStyle(
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.w500,
                      //             color: AppColor.tegTextColor,
                      //           ),
                      //         ),
                      //       ),
                      //       4.width,
                      //       Container(
                      //         height: double.maxFinite,
                      //         decoration: BoxDecoration(
                      //           color: AppColor.white,
                      //           borderRadius: BorderRadius.circular(100),
                      //           border: Border.all(color: AppColor.softBorderColor),
                      //         ),
                      //         alignment: Alignment.center,
                      //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      //         child: Text(
                      //           "Deep Learning",
                      //           style: TextStyle(
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.w500,
                      //             color: AppColor.tegTextColor,
                      //           ),
                      //         ),
                      //       ),
                      //       4.width,
                      //       Container(
                      //         height: double.maxFinite,
                      //         decoration: BoxDecoration(
                      //           color: AppColor.white,
                      //           borderRadius: BorderRadius.circular(100),
                      //           border: Border.all(color: AppColor.softBorderColor),
                      //         ),
                      //         alignment: Alignment.center,
                      //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      //         child: Text(
                      //           "Mental Health Awareness",
                      //           style: TextStyle(
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.w500,
                      //             color: AppColor.tegTextColor,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      15.height,
                    ],
                  ),
                ),
              ),

              // post
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
                    // print(item.likes);

                    // if (index == 2) {
                    //   return ImagePostTile(
                    //     profileUrl: "https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg",
                    //     userName: "Jerome Bell",
                    //     onProfileClick: () {
                    //       rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => OtherProfilePage()));
                    //     },
                    //     isVerify: true,
                    //     time: DateTime.now().subtract(Duration(minutes: 5)).toUtc().toString(),
                    //     topic: "How are virtual realities impacting our daily lives?",
                    //     message:
                    //         "Virtual Reality (VR) has been a rising technology for the past few years. While it started mainly in the gaming industry, it has now permeated into various sectors like education, healthcare, and even tourism. I'm curious to hear from others: How do you think VR is shaping our routines, interactions, and experiences in the current decade? Are there any unforeseen consequences or benefits that you've observed?",
                    //   );
                    // }

                    return TextPostTile(
                      profileUrl: item.userProfileImage!,
                      userName: item.username!,
                      onProfileClick: () {
                        // soon it will change
                        // rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => OtherProfilePage()));
                        AppUtils.slidePush(
                            page: OtherProfilePage(userId: item.userId!));
                      },
                      likes: item.likesCount,
                      replies: item.replysCount,
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
                          await CommunityDiscussionRepostory
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
