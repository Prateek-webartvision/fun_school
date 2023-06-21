// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/repo/study_plan_repo/study_plan_repo.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../router/app_router.dart';
import '../../router/pages.dart';
import '../../style/color.dart';
import '../../widegts/k_btn.dart';
import '../../widegts/k_text_field.dart';
import 'find_courses_by_school_page_state.dart';
import 'widgets/my_header_delegate.dart';
import 'widgets/school_selector.dart';
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
          print(controller.coursesBySearch);
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
                            // selected: true,
                            // work on it
                            onTap: () {
                              appRoutes.pushNamed(PagesName.coursesBySchoolDetailsPage);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => 8.height,
                      ),
          );
        },
      ),
      floatingActionButton: KBtn(
        onClick: () {
          AppUtils.showloadingOverlay(() async {
            await StudyPlanRepository.buyStudyPlan(1);
          });
        },
        text: "Add to Study Plan",
        width: MediaQuery.of(context).size.width - 32,
        height: 44,
        bgColor: Color(0xff6938EF),
      ),
    );
  }
}
