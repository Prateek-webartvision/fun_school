// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../uitls/app_utils.dart';
import '../../study_page/model/study_plan_model.dart';

class MyStudyPlanSheet extends StatefulWidget {
  const MyStudyPlanSheet({
    super.key,
    required this.myStudyPlan,
  });

  final List<StudyPlanModel> myStudyPlan;

  @override
  State<MyStudyPlanSheet> createState() => _MyStudyPlanSheetState();
}

class _MyStudyPlanSheetState extends State<MyStudyPlanSheet> {
  StudyPlanSelector studyPlanSelector = StudyPlanSelector();

  @override
  void dispose() {
    studyPlanSelector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: studyPlanSelector,
      builder: (context, child) {
        return Container(
          constraints: BoxConstraints(maxHeight: context.screenHeight - rootNavigator.currentContext!.viewPadding.top),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 48,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColor.scaffoldBg,
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                          onTap: () {
                            AppUtils.closeBottomSheet();
                          },
                          child: SizedBox(height: 48, child: Icon(Icons.close))),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Select Study Plan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemCount: widget.myStudyPlan.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        studyPlanSelector.selectPlan(widget.myStudyPlan[index]);
                        // print();
                        // rootNavigator.currentState!.pop(widget.myStudyPlan[index].title ?? "");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: (studyPlanSelector.selectedPlan?.studyPlanId != widget.myStudyPlan[index].studyPlanId) ? AppColor.softBorderColor : AppColor.mainColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.myStudyPlan[index].title ?? "N/A",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 10.height,
                ),
              ),

              //
              GestureDetector(
                onTap: () {
                  if (studyPlanSelector.selectedPlan != null) {
                    rootNavigator.currentState!.pop(studyPlanSelector.selectedPlan!.title ?? "");
                  }
                  // print(studyPlanSelector.selectedPlan!.studyPlanId.toString());
                },
                child: Container(
                  height: 44,
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: AppColor.mainColor, borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "add to".toUpperCase(),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class StudyPlanSelector extends ChangeNotifier {
  StudyPlanModel? selectedPlan;

  selectPlan(StudyPlanModel selectedPlan) {
    this.selectedPlan = selectedPlan;
    notifyListeners();
  }
}
