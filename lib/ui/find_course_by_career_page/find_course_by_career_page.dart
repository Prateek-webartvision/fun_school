// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/widegts/k_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../router/app_router.dart';
import '../../router/pages.dart';
import 'find_course_by_career_state.dart';
import 'widgets/select_intreset.dart';
import 'widgets/subject_card.dart';
import 'widgets/teg_selector.dart';

class FindCourseByCareerView extends StatefulWidget {
  const FindCourseByCareerView({super.key});
  @override
  State<FindCourseByCareerView> createState() => _FindCourseByCareerViewState();
}

class _FindCourseByCareerViewState extends FindCouresByCareerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text(
          "Courses by Career",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: findCourseByCareerController,
        builder: (controller) {
          if (controller.apiState == ApiState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.apiState == ApiState.error) {
            return Center(
              child: Text(controller.error.toString()),
            );
          } else {
            // on success
            return Column(
              children: [
                //head
                Container(
                  height: 126,
                  decoration: BoxDecoration(color: AppColor.white),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      KSearchField(onSubmmit: searchSubmmit),
                      12.height,
                      // career tags
                      TagSelector(
                        currentIndex: controller.currentCareerTagIndex,
                        tagSet: controller.careerSet,
                        onChanged: (index) => controller.changeCareerTag(index),
                      ),
                    ],
                  ),
                ),

                //list
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      SelectIntreset(
                        initInterest: controller.seletedInterest,
                        interestList: controller.interestSet.toList(),
                        onItemClick: (interest) {
                          controller.changeInterestTag(interest);
                        },
                      ),
                      12.height,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "School Level",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Junior secondary school",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              6.width,
                              GestureDetector(onTap: () {}, child: Icon(Icons.arrow_drop_down))
                            ],
                          ),
                        ],
                      ),
                      12.height,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.filterList!.length,
                        itemBuilder: (context, index) {
                          return SubjectCard(
                            name: "${controller.filterList?[index].courseName}",
                            icon: Icons.book,
                            onTap: () {
                              appRoutes.pushNamed(PagesName.coursesBySchoolDetailsPage);
                            },
                            // iconBg: Color(0xffEF6F38),
                          );
                        },
                        separatorBuilder: (context, index) => 8.height,
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
