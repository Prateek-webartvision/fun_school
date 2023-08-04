// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/ui/study_page/controller/my_courses_controller.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../router/app_router.dart';
import '../../../style/color.dart';
import '../../../widegts/k_btn.dart';
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
                padding: EdgeInsets.all(16).copyWith(bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: 44,
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: context.screenWidth * 0.5),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          clipBehavior: Clip.hardEdge,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return CreateFolderSheet(
                              onCreate: (fname) async {
                                controller.createFolder(fname);
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: context.theme.primaryColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.add, color: context.theme.primaryColor), 6.width, Text("create folder".capitalize!)],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.all(16).copyWith(bottom: 12, top: 0),
                sliver: SliverToBoxAdapter(
                  child: KSearchField(),
                ),
              ),
              //folders
              (controller.myFolders != null && controller.myCourses!.isNotEmpty)
                  ? SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
                      sliver: SliverToBoxAdapter(
                          child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: controller.myFolders!.length,
                        itemBuilder: (context, index) {
                          final item = controller.myFolders![index];
                          return Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: context.theme.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item.folderTitle!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => 10.height,
                      )))
                  : SliverToBoxAdapter(),
              //

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

class CreateFolderSheet extends StatefulWidget {
  const CreateFolderSheet({
    super.key,
    required this.onCreate,
  });
  final Function(String fname) onCreate;
  @override
  State<CreateFolderSheet> createState() => _CreateFolderSheetState();
}

class _CreateFolderSheetState extends State<CreateFolderSheet> {
  TextEditingController folderName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(height: 48, child: Icon(Icons.close))),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Create Folder",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        10.height,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              KTextField(
                controller: folderName,
                hint: "Title",
              ),
            ],
          ),
        ),

        10.height,

        // btns
        SizedBox(
          height: 56,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KBtn(
                height: 44,
                width: 165,
                onClick: () {
                  Navigator.of(context).pop();
                },
                text: "Cancel",
                bgColor: AppColor.white,
                borderSide: BorderSide(color: AppColor.softBorderColor),
                fbColor: Colors.black,
                borderRadius: 4,
              ),
              12.width,
              KBtn(
                width: 165,
                height: 44,
                onClick: () {
                  if (folderName.text.isEmpty) {
                    AppUtils.showSnack("Add Folder Title");
                  } else {
                    Navigator.of(context).pop();
                    widget.onCreate(folderName.text);
                  }
                },
                text: "Add New Folder",
                borderRadius: 4,
              ),
            ],
          ),
        ),
        20.height,
      ],
    );
  }
}
