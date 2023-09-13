// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import '../../style/const.dart';
import '../../style/theme.dart';
import 'controller/week_day_selector_controller.dart';
import 'widgets/plan_study_schedule_tile.dart';
import 'widgets/study_resourse_tile.dart';
import 'widgets/week_day_selector.dart';

class ExamStudyPlanDetailsPage extends StatefulWidget {
  const ExamStudyPlanDetailsPage({super.key});

  @override
  State<ExamStudyPlanDetailsPage> createState() => _ExamStudyPlanDetailsPageState();
}

class _ExamStudyPlanDetailsPageState extends State<ExamStudyPlanDetailsPage> {
  late WeekDaySelectorController weekDaySelectorController;
  List<int> weekDays = [1, 2, 3, 4, 5, 6, 7];

  @override
  void initState() {
    weekDaySelectorController = WeekDaySelectorController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        title: const Text("JAMB 2023"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _PlanHeadTile(),
          12.height,

          // Courses in exam
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: AppShadow.boxShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Courses in the Exam", style: AppTextStyle.text12W400),
                5.height,
                Wrap(
                  spacing: 8,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text("Mathematics", style: AppTextStyle.text12W400),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text("English", style: AppTextStyle.text12W400),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text("Physics", style: AppTextStyle.text12W400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          12.height,
          //
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: AppShadow.boxShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Study Schedule", style: AppTextStyle.text12W400),
                5.height,
                Column(
                  children: [
                    PlanStudyScheduleTile(
                      title: "Study Hours Required",
                      subTitle: "60 hours",
                    ),
                    5.height,
                    PlanStudyScheduleTile(
                      title: "Study Hours Completed",
                      subTitle: "24 hours",
                    ),
                    5.height,
                    PlanStudyScheduleTile(
                      title: "Preferred Study Periods",
                      subTitle: "Evenings",
                    ),
                    5.height,
                    PlanStudyScheduleTile.edit(
                      title: "Preferred Study Periods",
                      subTitle: "Daily at 7:00 pm",
                      onEdit: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
          12.height,
          // time table
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: AppShadow.boxShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Study Schedule", style: AppTextStyle.text12W400),
                12.height,
                DropdownButtonFormField(
                  style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: studyPlanDropBorder,
                    enabledBorder: studyPlanDropBorder,
                    focusedBorder: studyPlanDropBorder,
                  ),
                  items: [DropdownMenuItem(child: Text("Week1"))],
                  onChanged: (value) {},
                ),
                12.height,
                // week Day Selector
                WeekDaySelector(
                  weekDays: weekDays,
                  controller: weekDaySelectorController,
                ),
                //
                12.height,
                PlanStudyScheduleTile(
                  title: "Algebra",
                  subTitle: "6:00 pm - 8:00 pm",
                ),
                6.height,
                PlanStudyScheduleTile(
                  title: "Electricity",
                  subTitle: "08:00 pm - 10:00 pm",
                ),
              ],
            ),
          ),

          12.height,
          //
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: AppShadow.boxShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Resources", style: AppTextStyle.text12W400),
                12.height,
                StudyResourseTile(title: "Algebra Notes"),
                5.height,
                StudyResourseTile(title: "Geometry Video Lectures"),
                5.height,
                StudyResourseTile(title: "Prose Study Materials"),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColor.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: KBtn(
                height: 44,
                bgColor: AppColor.white,
                fbColor: Colors.black,
                borderSide: BorderSide(color: AppColor.softBorderColor),
                onClick: () {},
                text: "Edit Plan",
              ),
            ),
            12.width,
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // OnTab method
                },
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Start Study Session",
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanHeadTile extends StatelessWidget {
  // const _PlanHeadTile({
  //   super.key,
  // });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: AppShadow.boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "JAMB 2023",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          6.height,
          Text.rich(
            TextSpan(text: "Date : ", children: [
              TextSpan(
                text: DateFormat("MMMM d, yyy").format(DateTime(2023, 9, 10)),
              ),
            ]),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          6.height,
          Text.rich(
            TextSpan(text: "Progress : ", children: [
              TextSpan(text: "20 hours ("),
              TextSpan(text: "40% completed", style: TextStyle(color: AppColor.mainColor)),
              TextSpan(text: ")"),
            ]),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          6.height,
          LinearProgressIndicator(
            minHeight: 6,
            borderRadius: BorderRadius.circular(6),
            value: 40 / 100,
          )
        ],
      ),
    );
  }
}
