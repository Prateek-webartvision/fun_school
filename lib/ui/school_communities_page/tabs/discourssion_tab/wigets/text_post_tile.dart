// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../../models/community_discussion_model/community_discussion_model.dart';
import '../../../../../style/assets.dart';
import '../../../../../style/color.dart';
import '../../../../../uitls/helper.dart';
import '../../../../../widegts/overlaping_user_avtar.dart';

class TextPostTile extends StatelessWidget {
  const TextPostTile({
    super.key,
    required this.profileUrl,
    required this.userName,
    this.isVerify = false,
    required this.time,
    required this.topic,
    required this.message,
    this.isLiked,
    required this.type,
    this.first2Likes = const <Likes>[],
    this.media,
    this.likes = 0,
    this.replies = 0,
    this.onProfileClick,
    this.onLikeClick,
  });
  final String profileUrl;
  final String userName;
  final bool isVerify;
  final String time;
  final String? topic;
  final String? message;
  final bool? isLiked;
  final String type;
  final List<Likes>? first2Likes;
  final List<Media>? media;
  final int? likes;
  final int? replies;
  final Function()? onProfileClick;
  final Function()? onLikeClick;

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
                        image: DecorationImage(
                          image: NetworkImage(profileUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    12.width,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(userName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
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
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            4.height,
                          ],
                        ),
                      ),

                      // images
                      Visibility(
                        visible: (type == "image" && media!.isNotEmpty),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: double.maxFinite,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: media!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 100,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(media![index].src!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => 6.width,
                              ),
                            ),
                            10.height,
                          ],
                        ),
                      ),
                      // like, share, comment btns
                      Row(
                        children: [
                          InkWell(
                            onTap: onLikeClick,
                            child: Icon(
                              Icons.thumb_up_alt_rounded,
                              color: AppColor.mainColor,
                              size: 24,
                            ),
                          ),
                          12.width,
                          SvgPicture.asset(
                            AppAssets.svg.messageIcon,
                            height: 24,
                            width: 24,
                          ),
                          12.width,
                          SvgPicture.asset(
                            AppAssets.svg.rePostIcon,
                            height: 24,
                            width: 24,
                          ),
                          12.width,
                          SvgPicture.asset(
                            AppAssets.svg.sendIcon,
                            height: 24,
                            width: 24,
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
            children: [
              SizedBox(
                // color: Colors.green,
                width: 32,
                height: 16,
                child: (first2Likes!.isEmpty)
                    ? SizedBox()
                    : OverlapingUserAvtar(
                        likes: first2Likes!,
                        maxAvtatCount: 2,
                      ),
              ),
              12.width,
              Text(
                "$replies replies ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.lightTextColor,
                ),
              ),
              Text(
                "• $likes Likes",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.lightTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
