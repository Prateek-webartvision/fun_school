// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widegts/k_text_field.dart';

class MyCoursesTab extends StatelessWidget {
  const MyCoursesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        KSearchField(),
        12.height,
        Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(color: AppColor.softBorderColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              //top
              Container(
                // color: Colors.green,
                height: 64,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Up next for you",
                          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: context.theme.colorScheme.primary),
                        ),
                        2.height,
                        Text(
                          "Mathematics",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    // time
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.scaffoldBg,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColor.textFeildBorderColor),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        "1 hours",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //progress bar
              Container(
                // color: Colors.green,
                height: 38,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      "Progress",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    16.width,
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.1,
                        backgroundColor: AppColor.scaffoldBg,
                        color: context.theme.colorScheme.primary,
                        minHeight: 6,
                      ),
                    ),
                    16.width,
                    Text(
                      "10%",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
              // option btn
              Container(
                // color: Colors.green,
                height: 70,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 103,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home, size: 20),
                          Text(
                            "Exam",
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 103,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_fire_department_rounded, size: 20),
                          Text(
                            "Flash Card",
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 103,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.quiz_outlined, size: 20),
                          Text(
                            "Quiz",
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //
        12.height,
        Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(color: AppColor.softBorderColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              //top
              Container(
                // color: Colors.green,
                height: 44,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text(
                        //   "Up next for you",
                        //   style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: context.theme.colorScheme.primary),
                        // ),
                        // 2.height,
                        Text(
                          "English",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    // time
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.scaffoldBg,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColor.textFeildBorderColor),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        "1 hours",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //progress bar
              Container(
                // color: Colors.green,
                height: 38,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      "Progress",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    16.width,
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.1,
                        backgroundColor: AppColor.scaffoldBg,
                        color: context.theme.colorScheme.primary,
                        minHeight: 6,
                      ),
                    ),
                    16.width,
                    Text(
                      "10%",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
              // option btn
              Container(
                // color: Colors.green,
                height: 70,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 103,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home, size: 20),
                          Text(
                            "Exam",
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 103,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_fire_department_rounded, size: 20),
                          Text(
                            "Flash Card",
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 103,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.quiz_outlined, size: 20),
                          Text(
                            "Quiz",
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
