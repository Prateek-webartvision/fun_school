// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kd_utils/kd_utils.dart';

class DiscourssionTab extends StatefulWidget {
  const DiscourssionTab({super.key});

  @override
  State<DiscourssionTab> createState() => _DiscourssionTabState();
}

class _DiscourssionTabState extends State<DiscourssionTab> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
          itemBuilder: (context, index) {
            return Container(
              height: 215,
              width: double.maxFinite,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: AppColor.softBorderColor,
                          image: DecorationImage(
                            image: NetworkImage("https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      12.width,
                      Row(
                        children: [
                          Text("Jerome Bell", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          4.width,
                          Icon(
                            Icons.verified,
                            color: AppColor.mainColor,
                            size: 12,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text("33m"),
                          4.width,
                          Icon(Icons.more_horiz),
                        ],
                      ),
                    ],
                  ),
                  // dive line and message
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
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Importance of Quantum Physics in Modern Technology?",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                4.height,
                                Text(
                                  "Quantum physics is often considered the backbone of many modern...",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
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
          },
          separatorBuilder: (context, index) => Divider(height: 0),
        )
      ],
    );
  }
}
