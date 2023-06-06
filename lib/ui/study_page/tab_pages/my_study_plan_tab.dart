// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widegts/k_btn.dart';

class MyStudyPlanTab extends StatelessWidget {
  const MyStudyPlanTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // create plan btn
        CreatePlanBtn(onTap: () {}),
        12.height,
        // plans
        Container(
          height: 66,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(color: AppColor.textFeildBorderColor),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xff6519BA),
                child: Icon(
                  Icons.group,
                  color: Colors.white,
                ),
              ),
              10.width,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "14 hours  . 4 Courses",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "2023 Study Material",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              10.width,
              Icon(
                Icons.navigate_next_rounded,
                size: 20,
              )
            ],
          ),
        ),
        12.height,

        Container(
          height: 66,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(color: AppColor.textFeildBorderColor),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xffEF6F38),
                child: Icon(
                  Icons.sticky_note_2,
                  color: Colors.white,
                ),
              ),
              10.width,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "14 hours  . 4 Courses",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "2023 Plan",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              10.width,
              Icon(
                Icons.navigate_next_rounded,
                size: 20,
              )
            ],
          ),
        ),
      ],
    );
  }
}
