// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/exams/exam_study_plan_models/course_name_model.dart';
import '../../../style/color.dart';
import '../../../uitls/app_utils.dart';
import '../../../widegts/k_btn.dart';
import '../../../widegts/k_text_field.dart';

class CreateExamSheet extends StatefulWidget {
  const CreateExamSheet({super.key, required this.onCreate, required this.courses});
  final Function() onCreate;
  final List<CoursesName> courses;

  @override
  State<CreateExamSheet> createState() => _CreateExamSheetState();
}

class _CreateExamSheetState extends State<CreateExamSheet> {
  TextEditingController createTextFeild = TextEditingController();
  DateTime? dateOfExam;
  TextEditingController dateTextFeild = TextEditingController();
  TextEditingController courseTextFeild = TextEditingController();
  TextEditingController reminderTextFeild = TextEditingController();

  // @override
  // void initState() {
  //   // createTextFeild.text = "2023 Exam Test";
  //   // dateTextFeild.text = "Select Exam Date";
  //   // courseTextFeild.text = "Select Course";
  //   // reminderTextFeild.text = "30 mins before";
  //   super.initState();
  // }

  @override
  void dispose() {
    createTextFeild.dispose();
    dateTextFeild.dispose();
    courseTextFeild.dispose();
    reminderTextFeild.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 48,
                  width: double.maxFinite,
                  // Title
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => AppUtils.closeBottomSheet(),
                          child: Icon(Icons.close, size: 24),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Create New Study Plan",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                16.height,
                KTextField(
                  hint: "Name of the exam",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: createTextFeild,
                ),
                16.height,
                // date of exam
                GestureDetector(
                  onTap: () async {
                    DateTime currentDate = DateTime.now();
                    if (rootNavigator.currentState!.focusNode.hasFocus) {
                      rootNavigator.currentState!.focusNode.unfocus();
                      await Future.delayed(Duration(milliseconds: 200));
                    }

                    final date = await showDatePicker(
                      context: rootNavigator.currentContext!,
                      initialDate: dateOfExam ?? currentDate,
                      firstDate: currentDate,
                      lastDate: currentDate.add(Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        dateOfExam = date;
                        dateTextFeild.text = DateFormat("MMMM d, yyyy").format(dateOfExam!);
                      });
                    }
                  },
                  child: KTextField(
                    enabled: false,
                    suffixIcon: SvgPicture.asset(AppAssets.svg.calendarline2Icon),
                    hint: "Date of the exam",
                    controller: dateTextFeild,
                  ),
                ),
                16.height,
                // list of courses
                PopupMenuButton(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "List of courses in the exam",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColor.darkTextColor,
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(minHeight: 42),
                        decoration: BoxDecoration(
                          // color: Colors.green,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            color: AppColor.textFeildBorderColor,
                            width: 0.5,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Wrap(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.green,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: AppColor.textFeildBorderColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Mathematics",
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                        ),
                                        1.width,
                                        Icon(Icons.close, size: 12),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            10.width,
                            Icon(Icons.arrow_drop_down, color: Colors.black, size: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                  itemBuilder: (context) => widget.courses
                      .map(
                        (e) => PopupMenuItem(
                          value: e.id,
                          child: Text("${e.name}"),
                        ),
                      )
                      .toList(),
                ),
                16.height,
                KTextField(
                  hint: "Study hours required",
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  // controller: createTextFeild,
                ),
                16.height,
                PopupMenuButton(
                  child: KTextField(
                    enabled: false,
                    suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black, size: 24),
                    hint: "Preferred study periods",
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
                16.height,
                PopupMenuButton(
                  child: KTextField(
                    enabled: false,
                    suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black, size: 24),
                    hint: "Reminder settings",
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text("Daily"),
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
                    onClick: () {
                      AppUtils.closeBottomSheet();
                    },
                    text: "Cancel",
                    bgColor: AppColor.white,
                    fbColor: Colors.black,
                    borderSide: BorderSide(color: AppColor.softBorderColor),
                  ),
                ),
                12.width,
                Expanded(
                    child: KBtn(
                  onClick: () {
                    AppUtils.closeBottomSheet();
                    widget.onCreate();
                    // AppUtils.showSnack("coming soon");
                  },
                  text: "Create",
                  height: 44,
                )),
              ],
            ),
          ),
          20.height,
        ],
      ),
    );
  }
}
