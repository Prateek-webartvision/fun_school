// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../uitls/app_utils.dart';
import '../../../widegts/k_btn.dart';
import '../../../widegts/k_text_field.dart';

class CreateExamSheet extends StatefulWidget {
  const CreateExamSheet({super.key});

  @override
  State<CreateExamSheet> createState() => _CreateExamSheetState();
}

class _CreateExamSheetState extends State<CreateExamSheet> {
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
                          child: Icon(
                            Icons.close,
                            size: 24,
                          ),
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
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: createTextFeild,
                ),
                16.height,
                PopupMenuButton(
                  child: KTextField(
                    enabled: false,
                    suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black, size: 24),
                    hint: "Date of the exam",
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
                    hint: "List of courses in the exam",
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
                      AppUtils.showSnack("coming soon");
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
                    AppUtils.showSnack("coming soon");
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
