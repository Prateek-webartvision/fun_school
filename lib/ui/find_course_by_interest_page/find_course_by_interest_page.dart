// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import '../../widegts/k_text_field.dart';

class FindCourseByInterestPage extends StatelessWidget {
  const FindCourseByInterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text(
          "Courses by Interest",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //head
          Container(
            height: 72,
            decoration: BoxDecoration(
              color: AppColor.white,
            ),
            padding: EdgeInsets.all(16),
            child: KSearchField(),
          ),
          //
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _SelectIntreset(),
                12.height,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Proficiency Level",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Beginner",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        6.width,
                        GestureDetector(onTap: () {}, child: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                  ],
                ),
                12.height,
                _SubjectCard(name: "English", icon: Icons.group),
                8.height,
                _SubjectCard(name: "Literature", icon: Icons.book, iconBg: Color(0xffEF6F38)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//

class _SubjectCard extends StatelessWidget {
  const _SubjectCard({
    super.key,
    required this.name,
    required this.icon,
    this.onTap,
    this.iconBg,
  });
  final String name;
  final IconData icon;
  final Color? iconBg;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.softBorderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: iconBg ?? AppColor.mainColor,
              child: Icon(
                icon,
                color: AppColor.white,
              ),
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "14 hours",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    name,
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
            ),
            10.width,
            Icon(
              Icons.navigate_next_rounded,
              size: 20,
            ),
            // Checkbox(
            //   value: selected,
            //   fillColor: MaterialStatePropertyAll(AppColor.pinkColor),
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            //   side: BorderSide(
            //     color: AppColor.softBorderColor,
            //     width: 1,
            //   ),
            //   onChanged: (value) {},
            // )
          ],
        ),
      ),
    );
  }
}

//
class _SelectIntreset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Interest",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColor.softBorderColor),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Lawyer, Poet",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              10.width,
              GestureDetector(onTap: () {}, child: Icon(Icons.arrow_drop_down))
            ],
          ),
        ),
      ],
    );
  }
}
