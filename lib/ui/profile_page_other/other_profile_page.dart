// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/ui/profile_page_other/controller/other_profile_controller.dart';
import 'package:citycloud_school/utils/app_utils.dart';
import 'package:citycloud_school/widegts/error_page.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../widegts/overlaping_user_avtar.dart';
import 'other_profile_page_state.dart';
import 'tabs/post_tab.dart';

class OtherProfilePage extends StatefulWidget {
  const OtherProfilePage({super.key, required this.userId});
  final int userId;

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends OtherProfilePageState {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: otherProfileController,
      builder: (profile) {
        // loading
        if (profile.state == ApiState.loading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // error
        if (profile.state == ApiState.error) {
          return Scaffold(
            body: ErrorPage(
              error: profile.error!,
              onError: () {
                profile.reLoadProfil();
              },
            ),
          );
        }
        // print(profile.data!.userType);
        // success
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "@${profile.data!.username}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_rounded))
            ],
          ),
          body: Column(
            children: [
              Container(
                // height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // avtar
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColor.softBorderColor),
                            image: (profile.data!.profileImage != null)
                                ? DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        profile.data!.profileImage!),
                                    // image: CachedNetworkImageProvider(url),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment(1.3, 1.3),
                                child: getProfileBages(profile.data!.userType!),
                              )
                            ],
                          ),
                        ),
                        10.width,
                        // user name and badg
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  // "Jerome Bell",
                                  profile.data!.username!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                if (profile.data!.userType! ==
                                    "Certified_Tutor")
                                  Column(
                                    children: [
                                      4.width,
                                      SvgPicture.asset(AppAssets.svg.verified),
                                    ],
                                  ),
                              ],
                            ),
                            Text(
                              "@${profile.data!.username}",
                              // "@Jerome Bell",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // about user
                    Visibility(
                      visible: profile.data!.about != null,
                      child: Column(
                        children: [
                          5.height,
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Text(
                              profile.data!.about ?? "",
                              style: TextStyle(
                                  fontSize: 13.3,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    12.height,
                    // follers
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 20,
                          child: OverlapingUserAvtar(
                            avtarUrls: profile.data!.followersProfiles!
                                .map((e) => e.userProfileImage!)
                                .toList(),
                            // avtarUrls: [],
                            maxAvtatCount: 3,
                          ),
                        ),
                        4.width,
                        // followers count
                        Text(
                          "${profile.data!.followersProfiles?.length ?? 0} followers",
                          style: TextStyle(fontSize: 13.3),
                        ),
                      ],
                    ),
                    // follow btn
                    Visibility(
                      visible: profile.data!.userId! !=
                          AppStorage.user.currentUser()!.userId,
                      child: Column(
                        children: [
                          7.height,
                          KBtn(
                            width: double.maxFinite,
                            onClick: () {
                              AppUtils.showSnack("Coming soon");
                            },
                            text: (profile.data!.isFollowed)
                                ? "Unfollow"
                                : "Follow",
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // tab bar
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      text: "Discussions",
                    ),
                    Tab(
                      text: "Replies",
                    ),
                  ],
                ),
              ),

              // tab View
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    PostTab(controller: otherProfileController),
                    Center(
                      child: Text("Replies"),
                    )
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
