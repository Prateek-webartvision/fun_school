// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/ui/study_page/controller/my_courses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../router/app_router.dart';
import '../../../style/color.dart';
import '../../../widegts/k_text_field.dart';

class MyCoursesTab extends StatelessWidget {
  const MyCoursesTab({
    super.key,
    required this.myCoursesController,
  });
  final MyCoursesController myCoursesController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: myCoursesController,
      builder: (controller) {
        if (controller.apiState == ApiState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.apiState == ApiState.error) {
          return Center(child: Text(controller.error.toString()));
        } else if (controller.myCourses == null || controller.myCourses!.isEmpty) {
          return Center(child: Text("No Enrollment"));
        } else {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(16).copyWith(bottom: 12),
                sliver: SliverToBoxAdapter(
                  child: KSearchField(),
                ),
              ),
              // list
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
                sliver: SliverList.separated(
                  itemCount: controller.myCourses!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // print("${controller.myCourses![index]}");
                        appRoutes.pushNamed(PagesName.subjectDetailsPage, extra: controller.myCourses![index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border.all(color: AppColor.softBorderColor),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // appRoutes.pushNamed(PagesName.topicSummaryPage);
                              },
                              child: Column(
                                children: [
                                  //top
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Text(
                                            //   "Up next for you",
                                            //   style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: context.appTheme.colorScheme.primary),
                                            // ),
                                            // 2.height,
                                            Text(
                                              // "Mathematics",
                                              controller.myCourses![index].courseName!,
                                              style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // time
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.scaffoldBg,
                                            borderRadius: BorderRadius.circular(100),
                                            border: Border.all(color: AppColor.textFeildBorderColor),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          child: Text(
                                            "1 hours",
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  //progress bar
                                  Container(
                                    // color: Colors.green,
                                    height: 38,
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Progress",
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        16.width,
                                        Expanded(
                                          child: LinearProgressIndicator(
                                            // value: 0.1,
                                            value: double.parse(controller.getMyEnrollment(index).progress!) / 100,
                                            backgroundColor: AppColor.scaffoldBg,
                                            color: context.appTheme.colorScheme.primary,
                                            minHeight: 6,
                                          ),
                                        ),
                                        16.width,
                                        Text(
                                          // "10%",
                                          // "${controller.getMyEnrollment(index).progress}%",
                                          "${int.parse(controller.getMyEnrollment(index).progress!)}%",
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Divider(height: 0),
                            // // option btn
                            // Container(
                            //   // color: Colors.green,
                            //   height: 70,
                            //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       GestureDetector(
                            //         onTap: () {
                            //           AppUtils.showSnack("Coming soon");
                            //         },
                            //         child: SizedBox(
                            //           width: 103,
                            //           height: 70,
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             children: [
                            //               Icon(Icons.home, size: 20),
                            //               Text(
                            //                 "Exam",
                            //                 style: GoogleFonts.inter(
                            //                   fontSize: 10,
                            //                   fontWeight: FontWeight.w400,
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ),

                            //       // flash cards
                            //       GestureDetector(
                            //         onTap: () {
                            //           AppUtils.showloadingOverlay(() async {
                            //             final flashcard = await FlashCardRepository.getFlashCards(courseId: controller.myCourses![index].courseId!);

                            //             if (flashcard != null && flashcard.isNotEmpty) {
                            //               // print(flashcard);
                            //               rootNavigator.currentState!.push(
                            //                 MaterialPageRoute(
                            //                   builder: (context) => FlashCardView(flashCards: flashcard),
                            //                 ),
                            //               );
                            //             } else {
                            //               AppUtils.showSnack("No FlashCards");
                            //             }
                            //           });
                            //         },
                            //         child: SizedBox(
                            //           width: 103,
                            //           height: 70,
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             children: [
                            //               Icon(Icons.local_fire_department_rounded, size: 20),
                            //               Text(
                            //                 "Flash Card",
                            //                 style: GoogleFonts.inter(
                            //                   fontSize: 10,
                            //                   fontWeight: FontWeight.w400,
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //       // quiz btn
                            //       SizedBox(
                            //         width: 103,
                            //         height: 70,
                            //         child: GestureDetector(
                            //           onTap: () {
                            //             appRoutes.pushNamed(PagesName.startQuizPage, extra: controller.myCourses![index].courseId!);
                            //           },
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             children: [
                            //               Icon(Icons.quiz_outlined, size: 20),
                            //               Text(
                            //                 "Quiz",
                            //                 style: GoogleFonts.inter(
                            //                   fontSize: 10,
                            //                   fontWeight: FontWeight.w400,
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 12.height,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
