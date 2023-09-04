// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../../style/assets.dart';
import '../../../../../style/color.dart';
import '../../../../../uitls/helper.dart';

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
    this.first2Likes = const <String>[],
    this.likes = 0,
    this.replies = 0,
    this.onProfileClick,
  });
  final String profileUrl;
  final String userName;
  final bool isVerify;
  final String time;
  final String topic;
  final String message;
  final bool? isLiked;
  final List<String>? first2Likes;
  final int? likes;
  final int? replies;
  final Function()? onProfileClick;

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
                  Icon(Icons.more_horiz),
                ],
              ),
            ],
          ),
          // dive line and messagech

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
                      Text(
                        topic,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        // overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                      ),
                      4.height,
                      Text(
                        message,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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

          // like and all
          Row(
            children: [
              Container(
                color: Colors.green,
                width: 32,
                height: 16,
                child: (first2Likes!.isEmpty)
                    ? SizedBox()
                    : Stack(
                        children: List.generate(
                          (first2Likes!.length > 2) ? 2 : first2Likes!.length,
                          (index) {
                            return Positioned(
                              left: index * 9,
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  color: AppColor.softBorderColor,
                                  border: Border.all(color: AppColor.white),
                                  image: DecorationImage(
                                    image: NetworkImage(first2Likes![index]),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                // child: Align(
                //   alignment: Alignment(-.5, 0),
                //   child: SizedBox(
                //     width: 16,
                //     height: 16,
                //     child: Stack(
                //       alignment: Alignment.center,
                //       clipBehavior: Clip.none,
                //       fit: StackFit.expand,
                //       children: [
                //         Align(
                //           alignment: Alignment.center,
                //           child: Container(
                //             height: 16,
                //             width: 16,
                //             decoration: BoxDecoration(
                //               color: AppColor.softBorderColor,
                //               border: Border.all(color: AppColor.white),
                //               image: DecorationImage(
                //                 image: NetworkImage(
                //                     "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                //                 fit: BoxFit.cover,
                //               ),
                //               borderRadius: BorderRadius.circular(16),
                //             ),
                //           ),
                //         ),
                //         Positioned(
                //           right: -16 * 0.5,
                //           child: Container(
                //             height: 16,
                //             width: 16,
                //             decoration: BoxDecoration(
                //               color: AppColor.mainColor,
                //               borderRadius: BorderRadius.circular(16),
                //               border: Border.all(color: AppColor.white),
                //               image: DecorationImage(
                //                 image: NetworkImage(
                //                     "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ),
              12.width,
              Text(
                "$replies replies ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                "• $likes Likes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
