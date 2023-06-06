// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import 'tab_pages/my_courses_tab.dart';
import 'tab_pages/my_note_tab.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> with TickerProviderStateMixin {
  late TabController pageTabController;

  @override
  void initState() {
    pageTabController = TabController(length: 3, vsync: this);
    super.initState();
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
                  "Study",
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
                  tabs: [
                    Tab(text: "My courses"),
                    Tab(text: "My Notes"),
                    Tab(text: "My Study Plan"),
                  ],
                ),
              ],
            ),
          ),
          // 16.height,
          Expanded(
            child: TabBarView(
              controller: pageTabController,
              children: [
                MyCoursesTab(),
                MyNoteTab(),
                Center(
                  child: Text("Tab3"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
