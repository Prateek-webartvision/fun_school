// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widgets/k_btn.dart';

class ExamPrepTab extends StatelessWidget {
  const ExamPrepTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        CreateStudyPlanBtn(
          onTap: () {
            // AppUtils.showModelSheet(
            //   child: CreateExamSheet(),
            //   bgColor: Colors.white,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.vertical(
            //       top: Radius.circular(12),
            //     ),
            //   ),
            //   isScrolled: true,
            // );
          },
        ),
        12.height,
        GestureDetector(
          onTap: () {
            AppUtils.showSnack("Coming soon");
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(color: AppColor.softBorderColor),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Exam . 100 Questions",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Basic Biology Concepts Summary",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timelapse_rounded,
                            size: 15,
                            color: context.appTheme.colorScheme.primary,
                          ),
                          5.width,
                          Text(
                            "3 every 8 hours",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.navigate_next_rounded,
                  size: 20,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
