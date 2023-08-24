// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import 'wigets/image_post_tile.dart';
import 'wigets/text_post_tile.dart';

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
          itemCount: 3,
          itemBuilder: (context, index) {
            if (index == 2) {
              return ImagePostTile(
                profileUrl: "https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg",
                userName: "Jerome Bell",
                isVerify: true,
                time: DateTime.now().subtract(Duration(minutes: 5)).toUtc().toString(),
                topic: "How are virtual realities impacting our daily lives?",
                message:
                    "Virtual Reality (VR) has been a rising technology for the past few years. While it started mainly in the gaming industry, it has now permeated into various sectors like education, healthcare, and even tourism. I'm curious to hear from others: How do you think VR is shaping our routines, interactions, and experiences in the current decade? Are there any unforeseen consequences or benefits that you've observed?",
              );
            }

            return TextPostTile(
              profileUrl: "https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg",
              userName: "Jerome Bell",
              isVerify: true,
              time: DateTime.now().subtract(Duration(minutes: 33)).toUtc().toString(),
              topic: "Importance of Quantum Physics in Modern Technology?",
              message: "Quantum physics is often considered the backbone of many modern...",
            );
          },
          separatorBuilder: (context, index) => Divider(height: 0),
        )
      ],
    );
  }
}