// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../router/app_router.dart';
import '../../router/pages.dart';
import '../../style/color.dart';
import '../../widegts/k_text_field.dart';
import '../find_course_by_career_page/widgets/select_intreset.dart';
import '../find_course_by_career_page/widgets/subject_card.dart';
import 'find_course_by_interest_state.dart';
import 'widgets/proficiency_level_dropdown.dart';

class FindCourseByInterestView extends StatefulWidget {
  const FindCourseByInterestView({super.key});

  @override
  State<FindCourseByInterestView> createState() => _FindCourseByInterestViewState();
}

class _FindCourseByInterestViewState extends FindCourseByInterestState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text(
          "Courses by Interest",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: findCourseByInterestController,
        builder: (controller) {
          if (controller.apiState == ApiState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.apiState == ApiState.error) {
            return Center(
              child: Text(controller.error.toString()),
            );
          } else {
            // success
            return Column(
              children: [
                //head
                Container(
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                  ),
                  padding: EdgeInsets.all(16),
                  // search bar
                  child: KSearchField(onSubmmit: onSearch),
                ),
                //

                Expanded(
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverPadding(
                          padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 12),
                          sliver: SliverToBoxAdapter(
                            child: SelectIntreset(
                              initInterest: controller.interestQuery,
                              interestList: controller.interestSet.toList(),
                              onItemClick: onInterest,
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Proficiency Level",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: ProficiencyDropdown(
                                    initSelected: controller.proficiencyLevel,
                                    levelList: controller.proficiencySet.toList(),
                                    onItemClick: onLevel,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ];
                    },
                    body: ListView.separated(
                      padding: EdgeInsets.all(16),
                      itemCount: controller.filterList.length,
                      itemBuilder: (context, index) {
                        return SubjectCard(
                          name: controller.filterList[index].courseName!,
                          icon: Icons.book_rounded,
                          onTap: () {
                            appRoutes.pushNamed(
                              PagesName.subjectDetailsPage,
                              extra: controller.filterList[index],
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => 8.height,
                    ),
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
