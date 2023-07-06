// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../repo/study_plan_repo/study_plan_repo.dart';
import '../../router/app_router.dart';
import '../../router/pages.dart';
import '../../style/color.dart';
import '../../widegts/k_btn.dart';
import '../../widegts/k_text_field.dart';
import '../study_page/model/study_plan_model.dart';
import 'find_courses_by_school_page_state.dart';
import 'widgets/my_header_delegate.dart';
import 'widgets/school_selector.dart';
import 'widgets/select_study_plan_sheet.dart';
import 'widgets/subject_card.dart';

class FindCoursesBySchoolPageView extends StatefulWidget {
  const FindCoursesBySchoolPageView({super.key});

  @override
  State<FindCoursesBySchoolPageView> createState() => _FindCoursesBySchoolPageViewState();
}

class _FindCoursesBySchoolPageViewState extends FindCoursesBySchoolPageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses by School", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: AppColor.scaffoldBg,
      ),
      //
      body: GetBuilder(
        init: findCoursesBySchoolController,
        builder: (controller) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                // school selector
                SliverToBoxAdapter(
                  child: Container(
                    height: 114,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border(
                        top: BorderSide(color: AppColor.softBorderColor),
                        bottom: BorderSide(color: AppColor.softBorderColor),
                      ),
                    ),
                    child: SchoolSelector(
                      controller: controller.schoolSelectorController,
                    ),
                  ),
                ),

                // stiky search bar
                SliverPadding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  sliver: SliverPersistentHeader(
                    // pinned: true,
                    delegate: MyHeaderDelegate(
                      child: KSearchField(
                        onSubmmit: (value) => controller.searchSort(value),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: (controller.apiState == ApiState.loading)
                ? Center(child: CircularProgressIndicator())
                : (controller.apiState == ApiState.error)
                    ? Center(
                        child: Text(controller.error.toString()),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.all(16),
                        itemCount: controller.coursesBySearch!.length,
                        itemBuilder: (context, index) {
                          return SubjectCard(
                            // name: "Mathematics",
                            name: controller.coursesBySearch![index].courseName!,
                            icon: Icons.group,
                            selectedSubject: controller.selectedSubject,
                            onTap: () {
                              appRoutes.pushNamed(
                                PagesName.subjectDetailsPage,
                                extra: controller.coursesBySearch![index],
                              );
                            },
                            onItemSelected: () {
                              controller.changeCourseSelection(controller.coursesBySearch![index]);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => 8.height,
                      ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
        child: KBtn(
          onClick: () async {
            if (findCoursesBySchoolController.selectedSubject == null) {
              AppUtils.showSnack("Please Select Subject");
            } else {
              // get my studys plan
              List<StudyPlanModel>? myStudyPlan;
              await AppUtils.showloadingOverlay(() async {
                await StudyPlanRepository.getStudyPlans().then((value) {
                  myStudyPlan = value;
                }).onError((error, stackTrace) {
                  AppUtils.showSnack(error.toString());
                });
              });

              // show study plans list
              if (myStudyPlan != null && myStudyPlan!.isNotEmpty) {
                var res = await AppUtils.showModelSheet(
                  child: MyStudyPlanSheet(
                    myStudyPlan: myStudyPlan!,
                  ),
                  isScrolled: true,
                  bgColor: AppColor.white,
                  clip: Clip.hardEdge,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                );

                if (res != null) {
                  // print("res :$res");
                  AppUtils.showloadingOverlay(() async {
                    //Todo this must be changed
                    await StudyPlanRepository.buyStudyPlan(
                      courseTitle: findCoursesBySchoolController.selectedSubject!.courseName!,
                      studyPlan: res,
                    );
                  });
                }
              } else {
                AppUtils.showSnack("You dont have Study Plan, Create one");
              }
            }
          },
          text: "Add to Study Plan",
          width: MediaQuery.of(context).size.width - 32,
          height: 44,
          bgColor: Color(0xff6938EF),
        ),
      ),
    );
  }
}
