// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../../models/community_discussion_model/community_discussion_model.dart';

import '../../../../../style/assets.dart';
import '../../../../../style/color.dart';
import '../../../../../utils/helper.dart';
import '../../../../../widgets/overlaping_user_avtar.dart';
import '../../../../profile_page_other/controller/other_profile_controller.dart';

class DiscussionPostTile extends StatelessWidget {
  const DiscussionPostTile({
    super.key,
    this.profileUrl,
    required this.userName,
    this.isVerify = false,
    required this.time,
    this.topic,
    this.message,
    this.isLiked = false,
    required this.type,
    this.first2Likes = const <Likes>[],
    this.media,
    this.likes = 0,
    this.replies = 0,
    this.onProfileClick,
    this.onLikeClick,
    required this.userType,
    this.onComment,
    this.onOpenChat,
    this.hashTag,
  });

  final String? profileUrl;
  final String userName;
  final bool isVerify;
  final String time;
  final String? topic;
  final String? message;
  final bool isLiked;
  final String type;
  final String userType;
  final List<Likes>? first2Likes;
  final List<Media>? media;
  final int? likes;
  final int? replies;
  final Function()? onProfileClick;
  final Function()? onLikeClick;
  final Function()? onComment;
  final Function()? onOpenChat;
  final String? hashTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 215,
      width: double.maxFinite,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onProfileClick,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        color: AppColor.softBorderColor,
                        image: (profileUrl != null)
                            ? DecorationImage(
                                image: NetworkImage(profileUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(1.7, 1.7),
                            child: getProfileBadges(userType),
                          )
                        ],
                      ),
                    ),
                    12.width,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(userName,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                        4.width,
                        if (isVerify == true)
                          Icon(
                            Icons.verified,
                            color: AppColor.mainColor,
                            size: 12,
                          ),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              // Text("data"),
              Row(
                children: [
                  Text(timeCheck(yourTime: DateTime.parse(time))),
                  4.width,
                  InkWell(onTap: onProfileClick, child: Icon(Icons.more_horiz)),
                ],
              ),
            ],
          ),

          // topic, message, and images
          Container(
            // color: Colors.yellow,
            margin: EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 48),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // topic
                      Visibility(
                        visible: topic != null,
                        child: Column(
                          children: [
                            Text(
                              topic!,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              // overflow: TextOverflow.ellipsis,
                              // maxLines: 2,
                            ),
                            4.height,
                          ],
                        ),
                      ),
                      // Message
                      Visibility(
                        visible: message != null,
                        child: Column(
                          children: [
                            Text(
                              message!,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            4.height,
                          ],
                        ),
                      ),

                      // images
                      (type == "image" && media != null && media!.isNotEmpty)
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: double.maxFinite,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: media!.length,
                                    itemBuilder: (context, index) {
                                      final item = media![index];
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (context) {
                                              return Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: CachedNetworkImage(
                                                      imageUrl: item.src!),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            image: (media![index].src != null)
                                                ? DecorationImage(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                            media![index].src!),
                                                    fit: BoxFit.cover,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        6.width,
                                  ),
                                ),
                                10.height,
                              ],
                            )
                          : 0.height,

                      //* like, share, comment btn
                      Row(
                        children: [
                          InkWell(
                            onTap: onLikeClick,
                            child: Icon(
                              (isLiked)
                                  ? Icons.thumb_up_alt_rounded
                                  : Icons.thumb_up_alt_outlined,
                              color:
                                  (isLiked) ? AppColor.mainColor : Colors.black,
                              size: 24,
                            ),
                          ),
                          12.width,
                          GestureDetector(
                            onTap: onComment,
                            child: SvgPicture.asset(
                              AppAssets.svg.messageIcon,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          // 12.width,
                          // SvgPicture.asset(
                          //   AppAssets.svg.rePostIcon,
                          //   height: 24,
                          //   width: 24,
                          // ),
                          12.width,

                          GestureDetector(
                            onTap: onOpenChat,
                            child: SvgPicture.asset(
                              AppAssets.svg.sendIcon,
                              height: 24,
                              width: 24,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // like and all
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    // color: Colors.green,
                    width: 32,
                    height: 16,
                    child: (first2Likes!.isEmpty)
                        ? SizedBox()
                        : OverlayUserAvatar(
                            avatarUrls: first2Likes!
                                .map((e) => e.userProfileImage!)
                                .toList(),
                            maxAvatarCount: 2,
                          ),
                  ),
                  12.width,
                  Text(
                    "$likes Likes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.lightTextColor,
                    ),
                  ),
                  Text(
                    " • ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.lightTextColor,
                    ),
                  ),
                  Text(
                    "$replies replies ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.lightTextColor,
                    ),
                  ),
                ],
              ),
              //

              if (hashTag == "Jobs")
                Icon(
                  Icons.business,
                  color: context.theme.primaryColor,
                ), // for  job
              if (hashTag == "Discussions")
                Icon(Icons.groups,
                    color: context.theme.primaryColor), // for discuses
              if (hashTag == "Questions")
                Icon(Icons.contact_support,
                    color: context.theme.primaryColor), // question
            ],
          ),
        ],
      ),
    );
  }
}
