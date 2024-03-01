// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/style/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/exams/exam_study_plan_models/course_name_model.dart';
import '../../../style/color.dart';
import '../../../utils/app_utils.dart';
import '../../../widgets/k_btn.dart';
import '../../../widgets/k_text_field.dart';

class CreateExamSheet extends StatefulWidget {
  const CreateExamSheet(
      {super.key, required this.onCreate, required this.courses});
  final Function(
    String name,
    DateTime examDate,
    List<CoursesName> selectedCourses,
    String studyHour,
    String periods,
    String reminderSteeing,
    TimeOfDay reminderTime,
  ) onCreate;
  final List<CoursesName> courses;

  @override
  State<CreateExamSheet> createState() => _CreateExamSheetState();
}

class _CreateExamSheetState extends State<CreateExamSheet> {
  TextEditingController nameTextFeild = TextEditingController();
  DateTime? dateOfExam;
  Set<CoursesName> selectedCourses = {};
  TextEditingController studyHour = TextEditingController();
  TextEditingController periodsTextFeild = TextEditingController();
  TextEditingController reminderTextFeild = TextEditingController();
  TimeOfDay? selectedTime;

  TextEditingController dateTextFeild = TextEditingController();
  final List<String> timings = ["Evenings", "Mornings", "Afternoons"];
  final List<String> reminderSettings = ["Daily", "Weekly"];
  TextEditingController timeTextFeild = TextEditingController();

  @override
  void dispose() {
    nameTextFeild.dispose();
    dateTextFeild.dispose();
    studyHour.dispose();
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
          if (MediaQuery.of(rootNavigator.currentContext!).viewInsets.bottom !=
              0)
            rootNavigator.currentContext!.viewPadding.top.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(rootNavigator.currentContext!)
                        .viewInsets
                        .bottom ==
                    0)
                ? null
                : 497,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              children: [
                // Text("${context.screenHeight - MediaQuery.of(rootNavigator.currentContext!).viewInsets.bottom - rootNavigator.currentContext!.viewPadding.top}"),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    16.height,
                    KTextField(
                      hint: "Name of the exam",
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: nameTextFeild,
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
                            dateTextFeild.text =
                                DateFormat("MMMM d, yyyy").format(dateOfExam!);
                          });
                        }
                      },
                      child: KTextField(
                        enabled: false,
                        suffixIcon:
                            SvgPicture.asset(AppAssets.svg.calendarLine2Icon),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    runSpacing: 5,
                                    spacing: 5,
                                    children: selectedCourses
                                        .map(
                                          (e) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedCourses.remove(e);
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                // color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: AppColor
                                                      .textFeildBorderColor,
                                                  width: 0.5,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 9, vertical: 2),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    // "Mathematics",
                                                    e.name ?? "",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  1.width,
                                                  Icon(Icons.close, size: 12),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                10.width,
                                Icon(Icons.arrow_drop_down,
                                    color: Colors.black, size: 24),
                              ],
                            ),
                          ),
                        ],
                      ),
                      itemBuilder: (context) => widget.courses
                          .map(
                            (e) => PopupMenuItem(
                              value: e,
                              child: Text("${e.name}"),
                            ),
                          )
                          .toList(),
                      onSelected: (value) {
                        setState(() {
                          selectedCourses.add(value);
                        });
                      },
                      onOpened: () {
                        if (rootNavigator.currentState!.focusNode.hasFocus) {
                          rootNavigator.currentState!.focusNode.unfocus();
                        }
                      },
                    ),
                    16.height,
                    KTextField(
                      hint: "Study hours required",
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: studyHour,
                    ),
                    16.height,
                    // periods
                    PopupMenuButton(
                      child: KTextField(
                        enabled: false,
                        suffixIcon: Icon(Icons.arrow_drop_down,
                            color: Colors.black, size: 24),
                        hint: "Preferred study periods",
                        controller: periodsTextFeild,
                      ),
                      itemBuilder: (context) {
                        return timings
                            .map(
                              (e) => PopupMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList();
                      },
                      onOpened: () {
                        if (rootNavigator.currentState!.focusNode.hasFocus) {
                          rootNavigator.currentState!.focusNode.unfocus();
                        }
                      },
                      onSelected: (value) {
                        setState(() {
                          periodsTextFeild.text = value;
                        });
                      },
                    ),
                    16.height,
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: PopupMenuButton(
                            child: KTextField(
                              enabled: false,
                              suffixIcon: Icon(Icons.arrow_drop_down,
                                  color: Colors.black, size: 24),
                              hint: "Reminder settings",
                              controller: reminderTextFeild,
                            ),
                            itemBuilder: (context) {
                              return reminderSettings
                                  .map(
                                    (e) => PopupMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList();
                            },
                            onSelected: (value) {
                              reminderTextFeild.text = value;
                            },
                          ),
                        ),
                        16.width,
                        Expanded(
                          flex: 3,
                          child: GestureDetector(
                            onTap: () async {
                              TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (time != null) {
                                setState(() {
                                  selectedTime = time;
                                  timeTextFeild.text = time.format(context);
                                });
                              }
                              // print();
                            },
                            child: KTextField(
                              enabled: false,
                              // suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black, size: 24),
                              hint: "At",
                              controller: timeTextFeild,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
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
                          borderSide:
                              BorderSide(color: AppColor.softBorderColor),
                        ),
                      ),
                      12.width,
                      Expanded(
                          child: KBtn(
                        onClick: () {
                          AppUtils.closeBottomSheet();
                          if (nameTextFeild.text.isEmpty ||
                              dateOfExam == null ||
                              selectedCourses.isEmpty ||
                              studyHour.text.isEmpty ||
                              periodsTextFeild.text.isEmpty ||
                              reminderTextFeild.text.isEmpty ||
                              selectedTime == null) {
                            AppUtils.showSnack("All fields are mandatory");
                          } else {
                            widget.onCreate(
                              nameTextFeild.text,
                              dateOfExam!,
                              selectedCourses.toList(),
                              studyHour.text,
                              periodsTextFeild.text,
                              reminderTextFeild.text,
                              selectedTime!,
                            );
                          }
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
          ),
        ],
      ),
    );
  }
}
