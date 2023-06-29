// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/repo/study_plan_repo/study_plan_repo.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/ui/study_page/study_page.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:citycloud_school/widegts/k_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widegts/k_btn.dart';
import '../controller/my_study_plan_controller.dart';

class MyStudyPlanTab extends StatelessWidget {
  const MyStudyPlanTab({
    super.key,
    required this.myStudyPlanController,
  });
  final MyStudyPlanController myStudyPlanController;

  addStudyPlanBtn(BuildContext context) async {
    var res = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddStudyPlanSheet();
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
    if (res != null) {
      // capp get api
      myStudyPlanController.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: myStudyPlanController,
      builder: (controller) {
        if (controller.apiState == ApiState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.apiState == ApiState.error) {
          return Center(child: Text(controller.error.toString()));
        } else {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(16).copyWith(bottom: 12),
                sliver: SliverToBoxAdapter(
                  child: CreatePlanBtn(onTap: () => addStudyPlanBtn(context)),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(16).copyWith(top: 0),
                sliver: SliverList.separated(
                  itemCount: controller.studyPlans!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 66,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.textFeildBorderColor),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xff6519BA),
                            child: Icon(
                              Icons.group,
                              color: Colors.white,
                            ),
                          ),
                          10.width,
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "14 hours  . 4 Courses",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  // "2023 Study Material",
                                  controller.studyPlans![index].title ?? "N/A",
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          10.width,
                          Icon(
                            Icons.navigate_next_rounded,
                            size: 20,
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 12.height,
                ),
              ),
            ],
          );

          // return ListView(
          //   padding: EdgeInsets.all(16),
          //   children: [
          //     // create plan btn
          //     CreatePlanBtn(onTap: () {}),
          //     12.height,
          //     // plans
          //     Container(
          //       height: 66,
          //       width: double.maxFinite,
          //       decoration: BoxDecoration(
          //         color: AppColor.white,
          //         border: Border.all(color: AppColor.textFeildBorderColor),
          //         borderRadius: BorderRadius.circular(4),
          //       ),
          //       padding: EdgeInsets.all(12),
          //       child: Row(
          //         children: [
          //           CircleAvatar(
          //             radius: 20,
          //             backgroundColor: Color(0xff6519BA),
          //             child: Icon(
          //               Icons.group,
          //               color: Colors.white,
          //             ),
          //           ),
          //           10.width,
          //           Expanded(
          //             child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   "14 hours  . 4 Courses",
          //                   style: GoogleFonts.inter(
          //                     fontSize: 12,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //                 Text(
          //                   "2023 Study Material",
          //                   style: GoogleFonts.inter(
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           10.width,
          //           Icon(
          //             Icons.navigate_next_rounded,
          //             size: 20,
          //           )
          //         ],
          //       ),
          //     ),
          //     12.height,

          //     Container(
          //       height: 66,
          //       width: double.maxFinite,
          //       decoration: BoxDecoration(
          //         color: AppColor.white,
          //         border: Border.all(color: AppColor.textFeildBorderColor),
          //         borderRadius: BorderRadius.circular(4),
          //       ),
          //       padding: EdgeInsets.all(12),
          //       child: Row(
          //         children: [
          //           CircleAvatar(
          //             radius: 20,
          //             backgroundColor: Color(0xffEF6F38),
          //             child: Icon(
          //               Icons.sticky_note_2,
          //               color: Colors.white,
          //             ),
          //           ),
          //           10.width,
          //           Expanded(
          //             child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   "14 hours  . 4 Courses",
          //                   style: GoogleFonts.inter(
          //                     fontSize: 12,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //                 Text(
          //                   "2023 Plan",
          //                   style: GoogleFonts.inter(
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           10.width,
          //           Icon(
          //             Icons.navigate_next_rounded,
          //             size: 20,
          //           )
          //         ],
          //       ),
          //     ),
          //   ],
          // );
        }
      },
    );
  }
}

class AddStudyPlanSheet extends StatefulWidget {
  const AddStudyPlanSheet({
    super.key,
  });

  @override
  State<AddStudyPlanSheet> createState() => _AddStudyPlanSheetState();
}

class _AddStudyPlanSheetState extends State<AddStudyPlanSheet> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController desTextController = TextEditingController();

  @override
  void dispose() {
    titleTextController.dispose();
    desTextController.dispose();
    super.dispose();
  }

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
                  "Create Study Plan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // note take
        Container(
          // height: 141,
          width: double.maxFinite,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              KTextField(
                controller: titleTextController,
                hint: "Title",
                textInputAction: TextInputAction.next,
              ),
              12.height,
              KTextField(
                controller: desTextController,
                hint: "Description",
                maxLine: 3,
              ),
            ],
          ),
        ),

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
                  if (titleTextController.text.isEmpty || desTextController.text.isEmpty) {
                    AppUtils.showSnack("Enter Title and Description");
                  } else {
                    rootNavigator.currentState!.focusNode.unfocus();
                    AppUtils.showloadingOverlay(() async {
                      await StudyPlanRepository.addStudyPlan(title: titleTextController.text, description: desTextController.text).then((value) {
                        if (value['code'] == 200) {
                          Navigator.of(context).pop("yes");
                          AppUtils.showSnack(value['message']);
                        } else {
                          throw value['message'];
                        }
                        print(value);
                      }).onError((error, stackTrace) {
                        AppUtils.showSnack(error.toString());
                      });
                    });
                  }
                },
                text: "Add Study Plan",
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
