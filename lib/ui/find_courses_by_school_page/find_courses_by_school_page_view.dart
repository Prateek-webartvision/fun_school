// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:citycloud_school/widegts/error_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../repo/enroll_courses_repo/enroll_course_repo.dart';
import '../../router/app_router.dart';
import '../../router/pages.dart';
import '../../style/color.dart';
import '../../uitls/app_utils.dart';
import '../../widegts/k_text_field.dart';
import '../find_course_by_career_page/widgets/teg_selector.dart';
import 'find_courses_by_school_page_state.dart';
import 'widgets/select_school_dropdwon.dart';
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
      // body: GetBuilder(
      //   init: findCoursesBySchoolController,
      //   builder: (controller) {
      //     return NestedScrollView(
      //         physics: NeverScrollableScrollPhysics(),
      //         headerSliverBuilder: (context, innerBoxIsScrolled) {
      //           return [
      //             // school selector
      //             // SliverToBoxAdapter(
      //             //   child: Container(
      //             //     // height: 114,
      //             //     constraints: BoxConstraints(minHeight: 114, maxHeight: 130),
      //             //     decoration: BoxDecoration(
      //             //       color: AppColor.white,
      //             //       border: Border(
      //             //         top: BorderSide(color: AppColor.softBorderColor),
      //             //         bottom: BorderSide(color: AppColor.softBorderColor),
      //             //       ),
      //             //     ),
      //             //     child: SchoolSelector(controller: controller.schoolSelectorController),
      //             //   ),
      //             // ),

      //             SliverPadding(
      //               padding: EdgeInsets.symmetric(horizontal: 16),
      //               sliver: SliverToBoxAdapter(
      //                 child: SelectSchoolLevelDropDown(
      //                   schoolSelectorController: controller.schoolSelectorController,
      //                 ),
      //               ),
      //             ),

      //             // stiky search bar
      //             SliverPadding(
      //               padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      //               sliver: SliverPersistentHeader(
      //                 // pinned: true,
      //                 delegate: MyHeaderDelegate(
      //                   child: KSearchField(
      //                     onSubmmit: (value) => controller.searchSort(value),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ];
      //         },
      //         body: (controller.apiState == ApiState.loading)
      //             ? Center(child: CircularProgressIndicator())
      //             : (controller.apiState == ApiState.error)
      //                 ? Center(
      //                     child: Text(controller.error.toString()),
      //                   )
      //                 : (controller.coursesBySearch!.isEmpty)
      //                     ? Padding(
      //                         padding: const EdgeInsets.symmetric(horizontal: 30),
      //                         child: Center(
      //                           child: Text(
      //                             "No Courses to show try later, try to change school level, search keyword",
      //                             textAlign: TextAlign.center,
      //                             style: TextStyle(),
      //                           ),
      //                         ),
      //                       )
      //                     : CarouselSlider.builder(
      //                         itemCount: controller.coursesBySearch!.length,
      //                         itemBuilder: (context, index, realIndex) {
      //                           return Padding(
      //                             padding: const EdgeInsets.symmetric(horizontal: 16),
      //                             child: Column(
      //                               children: [
      //                                 SubjectCard(
      //                                   // name: "Mathematics",
      //                                   currentItem: controller.coursesBySearch![index],
      //                                   icon: Icons.book_rounded,
      //                                   selectedSubject: controller.selectedSubject,
      //                                   onTap: () {
      //                                     appRoutes.pushNamed(
      //                                       PagesName.subjectDetailsPage,
      //                                       extra: controller.coursesBySearch![index],
      //                                     );
      //                                   },
      //                                   onItemSelected: () {
      //                                     controller.changeCourseSelection(controller.coursesBySearch![index]);
      //                                   },
      //                                 ),
      //                               ],
      //                             ),
      //                           );
      //                         },
      //                         options: CarouselOptions(
      //                           initialPage: 0,
      //                           aspectRatio: 1,
      //                           viewportFraction: 1,
      //                           height: 160,
      //                           enableInfiniteScroll: false,
      //                           autoPlay: false,
      //                           onPageChanged: (index, reason) {
      //                             // smoothIndicatorTipController.changeIndex(index);
      //                           },
      //                         ),
      //                       )
      //         // : ListView.separated(
      //         //     padding: EdgeInsets.all(16),
      //         //     itemCount: controller.coursesBySearch!.length,
      //         //     itemBuilder: (context, index) {
      //         //       return SubjectCard(
      //         //         // name: "Mathematics",
      //         //         currentItem: controller.coursesBySearch![index],
      //         //         icon: Icons.book_rounded,
      //         //         selectedSubject: controller.selectedSubject,
      //         //         onTap: () {
      //         //           appRoutes.pushNamed(
      //         //             PagesName.subjectDetailsPage,
      //         //             extra: controller.coursesBySearch![index],
      //         //           );
      //         //         },
      //         //         onItemSelected: () {
      //         //           controller.changeCourseSelection(controller.coursesBySearch![index]);
      //         //         },
      //         //       );
      //         //     },
      //         //     separatorBuilder: (context, index) => 8.height,
      //         //   ),
      //         );
      //   },
      // ),

      // mew layout
      body: GetBuilder(
        init: findCoursesBySchoolController,
        builder: (controller) {
          if (controller.apiState == ApiState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.apiState == ApiState.error) {
            // return Center(child: Text(controller.error.toString()));
            return ErrorPage(
              error: controller.error.toString(),
              onError: () {
                controller.reload();
              },
            );
          } else {
            return ListView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16),
              children: [
                SelectSchoolLevelDropDown(
                  schoolSelectorController: controller.schoolSelectorController,
                  onSelect: (index) {
                    controller.schoolSelectorController.changeSchool(index);
                    controller.onSchoolChange();
                  },
                ),
                15.height,
                // search bar
                KSearchField(
                  onSubmmit: (value) => controller.searchSort(value),
                ),
                // career selector
                (controller.subSchoolSet != null)
                    ? Column(
                        children: [
                          15.height,
                          TagSelector(
                            currentIndex: controller.subScoolSelectionIndex,
                            tagSet: controller.subSchoolSet!,
                            onChanged: (index) {
                              controller.changeSubSchoolSet(index);
                            },
                          ),
                        ],
                      )
                    : 0.height,
                //
                20.height,
                // slider body
                (controller.coursesBySearch!.isEmpty)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Center(
                          child: Text(
                            "No Courses to show try later, try to change school level, search keyword",
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: controller.coursesBySearch!.length,
                            itemBuilder: (context, index, realIndex) {
                              final item = controller.coursesBySearch![index];
                              return GestureDetector(
                                onTap: () {
                                  appRoutes.pushNamed(
                                    PagesName.subjectDetailsPage,
                                    extra: item,
                                  );
                                },
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
                                      height: 420 - 93,
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
                                          Expanded(
                                            child: Image(
                                              width: double.maxFinite,
                                              // height: 250,
                                              image: NetworkImage(item.courseCoverImage!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                              initialPage: 0,
                              aspectRatio: 1,
                              viewportFraction: 1,
                              height: 420,
                              enableInfiniteScroll: false,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                smoothIndicatorTipController.changeIndex(index);
                              },
                            ),
                          ),
                          8.height,
                          // smooth page indicator
                          AnimatedBuilder(
                            animation: smoothIndicatorTipController,
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
                                  activeIndex: smoothIndicatorTipController.currentIndex,
                                  count: controller.coursesBySearch!.length,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: GetBuilder(
        init: findCoursesBySchoolController,
        builder: (controller) {
          if (controller.apiState == ApiState.success) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 20),
              child: Text.rich(
                TextSpan(
                  text: "Enrolled Courses are added to",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: " ",
                    ),
                    TextSpan(
                      text: '"My Courses"',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: " ",
                    ),
                    TextSpan(
                      text: "in the study tab for easy access",
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              // child: KBtn(
              //   onClick: () async {
              //     if (controller.selectedSubject.isEmpty) {
              //       AppUtils.showSnack("Please Select Subject");
              //     } else {
              //       // get my studys plan
              //       List<StudyPlanModel>? myStudyPlan;
              //       await AppUtils.showloadingOverlay(() async {
              //         await StudyPlanRepository.getStudyPlans().then((value) {
              //           myStudyPlan = value;
              //         }).onError((error, stackTrace) {
              //           AppUtils.showSnack(error.toString());
              //         });
              //       });

              //       // show study plans list
              //       if (myStudyPlan != null && myStudyPlan!.isNotEmpty) {
              //         var res = await AppUtils.showModelSheet(
              //           child: MyStudyPlanSheet(
              //             myStudyPlan: myStudyPlan!,
              //           ),
              //           isScrolled: true,
              //           bgColor: AppColor.white,
              //           clip: Clip.hardEdge,
              //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
              //         );

              //         if (res != null) {
              //           // print("res :$res");
              //           final selectedCourses = controller.selectedSubject;
              //           final listCourses = selectedCourses.map((e) => e.courseName!).toList();
              //           AppUtils.showloadingOverlay(() async {
              //             //Todo this must be changed
              //             await StudyPlanRepository.buyStudyPlan(
              //               courseTitle: listCourses,
              //               studyPlan: res,
              //             );
              //           });
              //         }
              //       } else {
              //         AppUtils.showSnack("You dont have Study Plan, Create one");
              //       }
              //     }
              //   },
              //   // text: "Add to Study Plan",
              //   text: "Add to my courses".capitalize!,
              //   width: MediaQuery.of(context).size.width - 32,
              //   height: 44,
              //   bgColor: Color(0xff6938EF),
              // ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
