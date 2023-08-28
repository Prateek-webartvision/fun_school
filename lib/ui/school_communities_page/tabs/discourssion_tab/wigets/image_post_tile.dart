// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../../style/assets.dart';
import '../../../../../style/color.dart';
import '../../../../../uitls/helper.dart';

class ImagePostTile extends StatelessWidget {
  const ImagePostTile({
    super.key,
    required this.profileUrl,
    required this.userName,
    this.isVerify = false,
    required this.time,
    required this.topic,
    required this.message,
    this.isLiked,
    this.last2Likes,
    this.likes,
    this.replies,
    this.onProfileClick,
  });
  final String profileUrl;
  final String userName;
  final bool isVerify;
  final String time;
  final String topic;
  final String message;
  final bool? isLiked;
  final List<String>? last2Likes;
  final int? likes;
  final int? replies;
  final Function()? onProfileClick;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 432,
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
                    Text(userName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    4.width,
                    if (isVerify == true)
                      Icon(
                        Icons.verified,
                        color: AppColor.mainColor,
                        size: 12,
                      ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(timeCheck(yourTime: DateTime.parse(time))),
                  4.width,
                  Icon(Icons.more_horiz),
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(
              // color: Colors.yellow,
              margin: EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    alignment: Alignment.center,
                    child: Container(
                      width: 4,
                      decoration: BoxDecoration(color: AppColor.softBorderColor, borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  12.width,
                  // message and image Tab
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          topic,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        4.height,
                        Text(
                          message,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                        ),
                        4.height,
                        Container(
                          height: 133,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColor.softBorderColor,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image:
                                    NetworkImage("https://media.istockphoto.com/id/1316805164/photo/woman-play-3d-vr-game.webp?b=1&s=170667a&w=0&k=20&c=Ok1otO3uZLZE3RTQXW8ZjfItZz3G43X1dr_916D9Gl4="),
                                fit: BoxFit.cover,
                              )),
                        ),
                        4.height,
                        Row(
                          children: [
                            Icon(
                              Icons.thumb_up_alt_rounded,
                              color: AppColor.mainColor,
                              size: 24,
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
          ),
          //
          Row(
            children: [
              SizedBox(
                width: 36,
                child: Align(
                  alignment: Alignment(-.5, 0),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: AppColor.softBorderColor,
                              border: Border.all(color: AppColor.white),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -16 * 0.5,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColor.white),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              12.width,
              Text(
                "26 replies ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                "• 112 Likes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
