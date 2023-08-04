// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../repo/enroll_courses_repo/enroll_course_repo.dart';
import '../../repo/study_plan_repo/study_plan_repo.dart';
import '../../router/app_router.dart';
import '../../router/pages.dart';
import '../../style/color.dart';
import '../../uitls/app_utils.dart';
import '../../widegts/k_btn.dart';
import '../../widegts/k_text_field.dart';
import '../find_course_by_career_page/widgets/select_intreset.dart';
import '../find_course_by_career_page/widgets/teg_selector.dart';
import '../find_courses_by_school_page/widgets/select_study_plan_sheet.dart';
import '../find_courses_by_school_page/widgets/subject_card.dart';
import '../study_page/model/study_plan_model.dart';
import 'find_course_by_interest_state.dart';

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
            return SingleChildScrollView(
              child: Column(
                children: [
                  //head
                  Container(
                    // height: 72,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                    ),
                    padding: EdgeInsets.all(16),
                    // search bar
                    child: Column(
                      children: [
                        SelectIntreset(
                          init: controller.interestindex,
                          interestSet: controller.interestSet,
                          onItemClick: onInterest,
                        ),
                        15.height,
                        KSearchField(onSubmmit: onSearch),
                        15.height,
                        TagSelector(
                          currentIndex: (controller.proficiencyLevel != null) ? controller.proficiencySet.toList().indexOf(controller.proficiencyLevel!) : null,
                          tagSet: controller.proficiencySet,
                          onChanged: (index) {
                            onLevel(controller.proficiencySet.elementAt(index));
                          },
                        ),
                      ],
                    ),
                  ),

                  //
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 3,
                  //         child: Text(
                  //           "Proficiency Level",
                  //           style: TextStyle(
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w600,
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 2,
                  //         child: ProficiencyDropdown(
                  //           initSelected: controller.proficiencyLevel,
                  //           levelList: controller.proficiencySet.toList(),
                  //           onItemClick: onLevel,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),

                  //
                  (controller.filterList.isEmpty)
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "No courses to show try later, try to change Interest, seach keyword",
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Column(children: [
                          10.height,
                          CarouselSlider.builder(
                            itemCount: controller.filterList.length,
                            itemBuilder: (context, index, realIndex) {
                              final item = controller.filterList[index];
                              return GestureDetector(
                                onTap: () {
                                  appRoutes.pushNamed(
                                    PagesName.subjectDetailsPage,
                                    extra: item,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Column(
                                    children: [
                                      SubjectCard(
                                        // name: "Mathematics",
                                        currentItem: item,
                                        icon: Icons.book_rounded,
                                        selectedSubject: controller.selectedSubject,

                                        onEnroll: () async {
                                          if (item.isCourseEnrolled == false) {
                                            await AppUtils.showloadingOverlay(() async {
                                              await EnrollCoursesRepository.enrollCourse(item.courseId).then((value) {
                                                if (value == 200) {
                                                  controller.updateEnrollers(item);
                                                }
                                              });
                                            });
                                          } else {
                                            AppUtils.showSnack("Already Enrolled");
                                          }
                                        },
                                        onItemSelected: () {
                                          if (item.isCourseEnrolled) {
                                            controller.changeCourseSelection(item);
                                          } else {
                                            AppUtils.showSnack("Enroll first");
                                          }
                                        },
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: 350,
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          border: Border.all(color: AppColor.softBorderColor),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SizedBox(
                                              // color: Colors.green,
                                              width: double.maxFinite,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  item.courseDescription!,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //image
                                            Image(
                                              width: double.maxFinite,
                                              height: 250,
                                              image: NetworkImage(item.courseCoverImage!),
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              initialPage: 0,
                              aspectRatio: 1,
                              viewportFraction: 1,
                              height: 350 + 93,
                              enableInfiniteScroll: false,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                smoothIndicatorController.changeIndex(index);
                              },
                            ),
                          ),
                          8.height,
                          AnimatedBuilder(
                            animation: smoothIndicatorController,
                            builder: (context, child) {
                              return Align(
                                alignment: Alignment.center,
                                child: AnimatedSmoothIndicator(
                                  effect: WormEffect(
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    activeDotColor: AppColor.mainColor,
                                    dotColor: AppColor.mainColor.withOpacity(0.3),
                                  ),
                                  activeIndex: smoothIndicatorController.currentIndex,
                                  count: controller.filterList.length,
                                ),
                              );
                            },
                          )
                        ]),

                  // Expanded(
                  //   child: NestedScrollView(
                  //     physics: NeverScrollableScrollPhysics(),
                  //     headerSliverBuilder: (context, innerBoxIsScrolled) {
                  //       return [];
                  //       // return [
                  //       //   SliverPadding(
                  //       //     padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 12),
                  //       //     sliver: SliverToBoxAdapter(
                  //       //       child: SelectIntreset(
                  //       //         initInterest: controller.interestQuery,
                  //       //         interestList: controller.interestSet.toList(),
                  //       //         onItemClick: onInterest,
                  //       //       ),
                  //       //     ),
                  //       //   ),
                  //       //   SliverPadding(
                  //       //     padding: EdgeInsets.symmetric(horizontal: 16),
                  //       //     sliver: SliverToBoxAdapter(
                  //       //       child: Row(
                  //       //         children: [
                  //       //           Expanded(
                  //       //             flex: 3,
                  //       //             child: Text(
                  //       //               "Proficiency Level",
                  //       //               style: TextStyle(
                  //       //                 fontSize: 14,
                  //       //                 fontWeight: FontWeight.w600,
                  //       //               ),
                  //       //             ),
                  //       //           ),
                  //       //           Expanded(
                  //       //             flex: 2,
                  //       //             child: ProficiencyDropdown(
                  //       //               initSelected: controller.proficiencyLevel,
                  //       //               levelList: controller.proficiencySet.toList(),
                  //       //               onItemClick: onLevel,
                  //       //             ),
                  //       //           )
                  //       //         ],
                  //       //       ),
                  //       //     ),
                  //       //   )
                  //       // ];
                  //     },
                  //     body: ListView.separated(
                  //       padding: EdgeInsets.all(16),
                  //       itemCount: controller.filterList.length,
                  //       itemBuilder: (context, index) {
                  //         return SubjectCard(
                  //           name: controller.filterList[index].courseName!,
                  //           icon: Icons.book_rounded,
                  //           onTap: () {
                  //             appRoutes.pushNamed(
                  //               PagesName.subjectDetailsPage,
                  //               extra: controller.filterList[index],
                  //             );
                  //           },
                  //         );
                  //       },
                  //       separatorBuilder: (context, index) => 8.height,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            );
          }
        },
      ),
      //
      bottomNavigationBar: GetBuilder(
        init: findCourseByInterestController,
        builder: (controller) {
          if (controller.apiState == ApiState.success) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
              child: KBtn(
                onClick: () async {
                  if (controller.selectedSubject.isEmpty) {
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
                        final selectedCourses = controller.selectedSubject;
                        final listCourses = selectedCourses.map((e) => e.courseName!).toList();
                        AppUtils.showloadingOverlay(() async {
                          //Todo this must be changed
                          await StudyPlanRepository.buyStudyPlan(
                            courseTitle: listCourses,
                            studyPlan: res,
                          );
                        });
                      }
                    } else {
                      AppUtils.showSnack("You dont have Study Plan, Create one");
                    }
                  }
                },
                // text: "Add to Study Plan",
                text: "Add to my courses".capitalize!,
                width: MediaQuery.of(context).size.width - 32,
                height: 44,
                bgColor: Color(0xff6938EF),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
