// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import '../../widegts/k_btn.dart';
import '../../widegts/k_text_field.dart';

class PrepareForAnExamPage extends StatelessWidget {
  const PrepareForAnExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text(
          "Prepare for an Exam",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      //
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
                Text(
                  "Find by popular exams",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                12.height,
                const _Tile(title: "JAMB", color: Color(0xff6519BA)),
                12.height,
                const _Tile(title: "WAEC", color: Color(0xffEF6F38)),
                12.height,
                const _Tile(title: "SSCE", color: Color(0xff3897EF)),
                12.height,
                Column(
                  children: [
                    Text(
                      "Can’t find exam",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    4.height,
                    Text(
                      "Search for course and click exam",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    12.height,
                    CreateStudyPlanBtn(
                      onTap: () {
                        AppUtils.showSnack("coming soon");
                      },
                      text: "Browse Course",
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({this.color, required this.title});
  final Color? color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppUtils.showSnack("coming soon");
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.softBorderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color,
              child: const Icon(Icons.edit_document, color: AppColor.white),
            ),
            10.width,
            Expanded(
                child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )),
            10.width,
            const Icon(
              Icons.navigate_next_rounded,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
