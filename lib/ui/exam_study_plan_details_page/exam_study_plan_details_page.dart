// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:kd_utils/methods/timestemp.dart';

import '../../models/exams/exam_study_plan_models/exam_study_plan_model.dart';
import '../../style/color.dart';
import '../../style/const.dart';
import '../../style/theme.dart';
import 'controller/week_day_selector_controller.dart';
import 'widgets/plan_head.dart';
import 'widgets/plan_study_schedule_tile.dart';
import 'widgets/week_day_selector.dart';

class ExamStudyPlanDetailsPage extends StatefulWidget {
  const ExamStudyPlanDetailsPage({super.key, required this.studyPlan});
  final ExamStudyPlanModel studyPlan;
  @override
  State<ExamStudyPlanDetailsPage> createState() => _ExamStudyPlanDetailsPageState();
}

class _ExamStudyPlanDetailsPageState extends State<ExamStudyPlanDetailsPage> {
  late ExamStudyPlanDetailsController studyPlanDetailsController;

  @override
  void initState() {
    studyPlanDetailsController = ExamStudyPlanDetailsController(studyPlan: widget.studyPlan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        // title: const Text("JAMB 2023"),
        title: Text(widget.studyPlan.examName ?? ""),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))],
      ),
      body: GetBuilder(
        init: studyPlanDetailsController,
        builder: (controller) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              PlanHeadTile(
                title: controller.studyPlan.examName ?? "",
                date: getDateTimeFromTimeStamp(timeStamp: controller.studyPlan.dateOfExam),
                progressHour: int.parse(controller.studyPlan.progressHours ?? "0"),
                progress: controller.studyPlan.progressPercentage?.toInt() ?? 0,
              ),
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
                      children: controller.studyPlan.examStudyPlanCourses!
                          .map(
                            (e) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: Text(e.name ?? "N/A", style: AppTextStyle.text12W400),
                            ),
                          )
                          .toList(),
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
                          // subTitle: "60 hours",
                          subTitle: "${controller.studyPlan.studyHours} hours",
                        ),
                        5.height,
                        PlanStudyScheduleTile(
                          title: "Study Hours Completed",
                          // subTitle: "24 hours",
                          subTitle: "${controller.studyPlan.progressHours} hours",
                        ),
                        5.height,
                        PlanStudyScheduleTile(
                          title: "Preferred Study Periods",
                          // subTitle: "Evenings",
                          subTitle: controller.studyPlan.studyPeriods ?? "N/A",
                        ),
                        5.height,
                        PlanStudyScheduleTile.edit(
                          title: "Preferred Study Periods",
                          // subTitle: "Daily at 7:00 pm",
                          subTitle: controller.studyPlan.reminderSettings ?? "N/A",
                          onEdit: () {
                            AppUtils.showSnack("Coming soon");
                          },
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
                      value: controller.selectedWeek,
                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        border: studyPlanDropBorder,
                        enabledBorder: studyPlanDropBorder,
                        focusedBorder: studyPlanDropBorder,
                      ),
                      // items: [DropdownMenuItem(child: Text("Week1"))],
                      items: controller.weekSet
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),

                      onChanged: (value) {
                        if (value != null && value != controller.selectedWeek) {
                          controller.setWeek = value;
                        }
                      },
                    ),
                    12.height,
                    // week Day Selector
                    WeekDaySelector(
                      weekDays: controller.weekDays,
                      controller: controller.weekDaySelectorController,
                      onChange: () {
                        controller.onDayChange();
                      },
                    ),
                    //
                    12.height,
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.timeTable.length,
                      itemBuilder: (context, index) {
                        final table = controller.timeTable[index];
                        return PlanStudyScheduleTile(
                          title: table.subject ?? "",
                          // subTitle: "6:00 pm - 8:00 pm",
                          subTitle: table.period ?? "",
                        );
                      },
                      separatorBuilder: (context, index) => 6.height,
                    ),
                    // PlanStudyScheduleTile(
                    //   title: "Algebra",
                    //   subTitle: "6:00 pm - 8:00 pm",
                    // ),
                    // 6.height,
                    // PlanStudyScheduleTile(
                    //   title: "Electricity",
                    //   subTitle: "08:00 pm - 10:00 pm",
                    // ),
                  ],
                ),
              ),

              // 12.height,
              // //
              // Container(
              //   padding: EdgeInsets.all(12),
              //   decoration: BoxDecoration(
              //     color: AppColor.white,
              //     borderRadius: BorderRadius.circular(4),
              //     boxShadow: AppShadow.boxShadow,
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text("Resources", style: AppTextStyle.text12W400),
              //       12.height,
              //       StudyResourseTile(title: "Algebra Notes"),
              //       5.height,
              //       StudyResourseTile(title: "Geometry Video Lectures"),
              //       5.height,
              //       StudyResourseTile(title: "Prose Study Materials"),
              //     ],
              //   ),
              // ),
            ],
          );
        },
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

class ExamStudyPlanDetailsController extends GetxController {
  final ExamStudyPlanModel studyPlan;
  late Set<String> _weekSet;
  late String selectedWeek;

  List<TimeTableModel> timeTable = [];

  late WeekDaySelectorController weekDaySelectorController;
  List<int> weekDays = [1, 2, 3, 4, 5, 6, 7];

  ExamStudyPlanDetailsController({required this.studyPlan}) {
    weekDaySelectorController = WeekDaySelectorController();
    _weekSet = studyPlan.examStudyPlanTimetable!.reversed.map((e) => e.week!).toSet();
    selectedWeek = _weekSet.first;
    _filterData();
  }

  List<String> get weekSet => _weekSet.toList();

  set setWeek(String week) {
    selectedWeek = week;
    _filterData();
    update();
  }

  onDayChange() {
    _filterData();
    // update();
  }

  _filterData() {
    final temp = studyPlan.examStudyPlanTimetable?.where(
      (element) => element.week == selectedWeek && int.parse(element.day.toString()) == (weekDaySelectorController.currentIndex + 1),
    );
    timeTable = temp?.toList() ?? [];
    update();
  }
}
