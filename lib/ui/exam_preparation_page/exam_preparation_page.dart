// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import '../../widegts/k_btn.dart';

class ExamPreparationPage extends StatefulWidget {
  const ExamPreparationPage({super.key});

  @override
  State<ExamPreparationPage> createState() => _ExamPreparationPageState();
}

class _ExamPreparationPageState extends State<ExamPreparationPage> with TickerProviderStateMixin {
  late TabController pageTabController;

  @override
  void initState() {
    pageTabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    pageTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBg,
      body: Column(
        children: [
          Container(
            color: AppColor.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 16),
                Text(
                  "Exam Preparation",
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                // 14.height,
                TabBar(
                  controller: pageTabController,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return states.contains(MaterialState.focused) ? null : Colors.transparent;
                    },
                  ),
                  splashBorderRadius: BorderRadius.circular(100),
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: AppColor.unSelectedTapColor,
                  labelPadding: EdgeInsets.only(right: 24),
                  tabs: const [
                    Tab(text: "Exam prep"),
                    Tab(text: "Find an exam"),
                    Tab(text: "Create exam timetable"),
                    Tab(text: "My Assessment"),
                  ],
                ),
              ],
            ),
          ),

          //
          Expanded(
            child: TabBarView(
              controller: pageTabController,
              children: [
                ExamPrepTab(),
                Center(
                  child: Text("Find an exam"),
                ),
                Center(
                  child: Text("Create exam timetable"),
                ),
                Center(
                  child: Text("My Assessment"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

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
          onTap: () {},
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
