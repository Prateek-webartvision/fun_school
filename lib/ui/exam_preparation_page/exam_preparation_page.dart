// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../style/color.dart';
import 'tab_pages/exam_prep_tab.dart';
import 'tab_pages/find_an_exam_tab.dart';

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
                FindAnExamTab(),
                Center(child: Text("coming soon")),
                Center(child: Text("coming soon")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
