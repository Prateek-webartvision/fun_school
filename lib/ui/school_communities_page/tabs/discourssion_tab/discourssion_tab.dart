// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/ui/profile_page_other/other_profile_page.dart';
import 'package:citycloud_school/widegts/error_page.dart';
import 'package:flutter/material.dart';
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
                          Text(
                            "See All",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.mainColor),
                          )
                        ],
                      ),
                      12.height,
                      SizedBox(
                        height: 34,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: AppColor.softBorderColor),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Text(
                                "Mars Colonization",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.tegTextColor,
                                ),
                              ),
                            ),
                            4.width,
                            Container(
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: AppColor.softBorderColor),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Text(
                                "Deep Learning",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.tegTextColor,
                                ),
                              ),
                            ),
                            4.width,
                            Container(
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: AppColor.softBorderColor),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Text(
                                "Mental Health Awareness",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.tegTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      15.height,
                    ],
                  ),
                ),
              ),

              // post

              SliverList.separated(
                itemCount: controller.discussions!.length,
                itemBuilder: (context, index) {
                  final item = controller.discussions![index];

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
                      rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => OtherProfilePage()));
                    },
                    likes: item.likesCount,
                    replies: item.replysCount,
                    time: DateTime.fromMicrosecondsSinceEpoch(int.parse(item.time!) * 1000000).toUtc().toString(),
                    topic: item.text!,
                    first2Likes: [
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
                    ],
                    // topic: "Importance of Quantum Physics in Modern Technology?",
                    message: "Quantum physics is often considered the backbone of many modern...",
                    // message: "${DateTime.fromMicrosecondsSinceEpoch(int.parse(item.time!) * 1000000).toLocal()}",
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
