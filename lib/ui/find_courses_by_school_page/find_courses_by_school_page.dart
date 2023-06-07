// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';
import '../../widegts/k_text_field.dart';

class FindCoursesBySchoolPage extends StatelessWidget {
  const FindCoursesBySchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Courses by School",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColor.scaffoldBg,
      ),
      body: ListView(
        children: [
          Container(
            height: 114,
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border(
                top: BorderSide(color: AppColor.softBorderColor),
                bottom: BorderSide(color: AppColor.softBorderColor),
              ),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                CollageCards(
                  name: "Junior secondary school",
                  icon: Icons.account_balance_sharp,
                ),
                10.width,
                CollageCards(
                  name: "Senior secondary school",
                  icon: Icons.business_outlined,
                  isSelected: true,
                ),
                10.width,
                CollageCards(
                  name: "University",
                  icon: Icons.temple_buddhist_outlined,
                ),
              ],
            ),
          ),
          16.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                KSearchField(),
                12.height,
                SubjectCard(
                  name: "Mathematics",
                  icon: Icons.group,
                  selected: true,
                  onTap: () {
                    appRoutes.pushNamed(PagesName.coursesBySchoolDetailsPage);
                  },
                ),
                8.height,
                SubjectCard(name: "English", icon: Icons.group, selected: false),
                8.height,
                SubjectCard(name: "Physics", icon: Icons.group, selected: false),
                8.height,
                SubjectCard(name: "Chemistry", icon: Icons.group, selected: false),
                8.height,
                SubjectCard(name: "Biology", icon: Icons.group, selected: false),
                8.height,
                SubjectCard(name: "Economics", icon: Icons.group, selected: false),
              ],
            ),
          ),
          10.height,
        ],
      ),
      floatingActionButton: KBtn(
        onClick: () async {},
        text: "Add to Study Plan",
        width: MediaQuery.of(context).size.width - 32,
        height: 44,
        bgColor: Color(0xff6938EF),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    super.key,
    required this.name,
    required this.icon,
    this.selected = false,
    this.onTap,
  });
  final String name;
  final IconData icon;
  final bool selected;

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
              backgroundColor: AppColor.mainColor,
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
                    "14 hours . Downloadable",
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
            Checkbox(
              value: selected,
              fillColor: MaterialStatePropertyAll(AppColor.pinkColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              side: BorderSide(
                color: AppColor.softBorderColor,
                width: 1,
              ),
              onChanged: (value) {},
            )
          ],
        ),
      ),
    );
  }
}

class CollageCards extends StatelessWidget {
  const CollageCards({
    super.key,
    required this.name,
    required this.icon,
    this.isSelected = false,
  });
  final String name;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (isSelected) ? Color(0xffF670C7).withOpacity(0.1) : Colors.white,
        border: Border.all(color: (isSelected) ? Color(0xffF670C7) : AppColor.softBorderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColor.mainColor,
            radius: 15,
            child: Icon(
              icon,
              color: Colors.white,
              size: 12,
            ),
          ),
          6.height,
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
