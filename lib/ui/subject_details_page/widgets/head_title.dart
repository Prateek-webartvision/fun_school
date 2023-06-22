// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({
    super.key,
    required this.controller,
    required this.title,
    required this.tabs,
  });

  final TabController controller;
  final List<String> tabs;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // subject head title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "14 hours . Downloadable",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    // "Mathematics",
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  4.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.play_circle_fill_rounded,
                        color: Color(0xff6938EF),
                        size: 18,
                      ),
                      6.width,
                      Text(
                        "Videos",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      13.width,
                      Icon(
                        Icons.info_rounded,
                        color: Color(0xff6938EF),
                        size: 18,
                      ),
                      6.width,
                      Text(
                        "Quizzes",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              // subject add btn
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(48),
                  border: Border.all(color: AppColor.softBorderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0F101828),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                    BoxShadow(
                      color: Color(0x1A101828),
                      offset: Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.add_rounded,
                  color: AppColor.mainColor,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        // tab bar
        Container(
          height: 28,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: TabBar(
            controller: controller,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            splashFactory: NoSplash.splashFactory,
            dividerColor: Colors.transparent,
            unselectedLabelColor: AppColor.unSelectedTapColor,
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

// [
              // Tab(text: "Algebra"),
              // Tab(text: "Ratios"),
              // Tab(text: "Trigonometry"),
            // ],
