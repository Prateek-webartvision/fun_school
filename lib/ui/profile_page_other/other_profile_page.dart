// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycloud_school/repo/community/community_discussion_repo.dart';
import 'package:citycloud_school/repo/profile_repo/others_profile.dart';
import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/widegts/error_page.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

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

        // success
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "@${profile.data!.username}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_rounded))],
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
                                    image: CachedNetworkImageProvider(profile.data!.profileImage!),
                                    // image: CachedNetworkImageProvider(url),
                                    fit: BoxFit.cover,
                                  )
                                : null,
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
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                ),
                                4.width,
                                SvgPicture.asset(AppAssets.svg.scholar)
                              ],
                            ),
                            Text(
                              "@${profile.data!.username}",
                              // "@Jerome Bell",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                              style: TextStyle(fontSize: 13.3, fontWeight: FontWeight.w500, color: Colors.black),
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
                          child: Stack(
                            // alignment: Alignment.centerLeft,
                            fit: StackFit.loose,
                            children: [
                              Align(
                                alignment: Alignment(-1, 0),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    image: DecorationImage(
                                      image: NetworkImage("https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColor.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(-0.3, 0),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    image: DecorationImage(
                                      image: NetworkImage("https://images.pexels.com/photos/428364/pexels-photo-428364.jpeg"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColor.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0.4, 0),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    image: DecorationImage(
                                      image: NetworkImage("https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColor.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        4.width,
                        // followers count
                        Text(
                          "${profile.data!.followers} followers",
                          style: TextStyle(fontSize: 13.3),
                        ),
                      ],
                    ),
                    7.height,
                    // follow btn
                    KBtn(
                      width: double.maxFinite,
                      onClick: () {},
                      text: "Follow",
                    )
                  ],
                ),
              ),
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
                    PostTab(),
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

abstract class OtherProfilePageState extends State<OtherProfilePage> with TickerProviderStateMixin {
  late TabController tabController;
  late OtherProfileController otherProfileController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    otherProfileController = OtherProfileController(widget.userId);
    super.initState();
  }
}

class OtherProfileController extends GetxController {
  late ApiState state;
  String? error;
  OtherProfileModel? data;
  final int userId;

  OtherProfileController(this.userId) {
    state = ApiState.loading;
    _iniLoadProfile();
  }

  // load profile
  _iniLoadProfile() async {
    // CommunityDiscussionRepostory
    await OthersProfileRepository.getProfile(userId: userId.toString()).then((value) {
      data = value;
      state = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      state = ApiState.error;
    });
    update();
    // await CommunityDiscussionRepostory.filterDiscussionByUser(userId: userId.toString()).then((value) {
    //   print(value);
    // }).onError((error, stackTrace) {
    //   print(error);
    // });
  }

  // reload profile
  reLoadProfil() async {
    await _iniLoadProfile();
  }
}
