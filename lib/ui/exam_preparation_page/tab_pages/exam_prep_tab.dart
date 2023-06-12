// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widegts/k_btn.dart';
import '../../../widegts/k_text_field.dart';

class ExamPrepTab extends StatelessWidget {
  const ExamPrepTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        CreatePlanBtn(
          onTap: () {
            AppUtils.showModelSheet(
              child: _CreateExamSheet(),
              bgColor: AppColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              isScrolled: true,
            );
          },
        ),
        12.height,
        Container(
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
                          color: context.theme.colorScheme.primary,
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
        )
      ],
    );
  }
}

class _CreateExamSheet extends StatefulWidget {
  // const _CreateExamSheet({

  @override
  State<_CreateExamSheet> createState() => _CreateExamSheetState();
}

class _CreateExamSheetState extends State<_CreateExamSheet> {
  TextEditingController createTextFeild = TextEditingController();
  TextEditingController dateTextFeild = TextEditingController();
  TextEditingController courseTextFeild = TextEditingController();
  TextEditingController reminderTextFeild = TextEditingController();

  @override
  void initState() {
    createTextFeild.text = "2023 Exam Test";
    dateTextFeild.text = "Select Exam Date";
    courseTextFeild.text = "Select Course";
    reminderTextFeild.text = "30 mins before";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 48,
                width: double.maxFinite,
                color: Color(0xfff4f4f4),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.close,
                          size: 24,
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Create Exam",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              16.height,
              KTextField(
                hint: "Title Exam",
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: createTextFeild,
              ),
              16.height,
              PopupMenuButton(
                child: KTextField(
                  enabled: false,
                  suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black, size: 24),
                  hint: "Add Exam Date",
                  controller: dateTextFeild,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Select Exam Date"),
                    )
                  ];
                },
              ),
              16.height,
              PopupMenuButton(
                child: KTextField(
                  enabled: false,
                  suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black, size: 24),
                  hint: "Add Course",
                  controller: courseTextFeild,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Select Exam Date"),
                    )
                  ];
                },
              ),
              16.height,
              PopupMenuButton(
                child: KTextField(
                  enabled: false,
                  suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black, size: 24),
                  hint: "Set Reminder",
                  controller: reminderTextFeild,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Select Exam Date"),
                    )
                  ];
                },
              ),
            ],
          ),
        ),
        Divider(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: KBtn(
                  height: 44,
                  onClick: () {},
                  text: "Cancel",
                  bgColor: AppColor.white,
                  fbColor: Colors.black,
                  borderSide: BorderSide(color: AppColor.softBorderColor),
                ),
              ),
              12.width,
              Expanded(
                  child: KBtn(
                onClick: () {},
                text: "Create",
                height: 44,
              )),
            ],
          ),
        ),
        20.height,
      ],
    );
  }
}
