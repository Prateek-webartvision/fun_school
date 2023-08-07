// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/courses.model.dart';
import '../../../repo/study_plan_repo/study_plan_repo.dart';
import '../../../router/app_router.dart';
import '../../../router/pages.dart';
import '../../../style/color.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({super.key, required this.coursesByFolderId, required this.allcourses});
  final List<FolderCourseModel> coursesByFolderId;
  final List<CoursesModel> allcourses;

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.coursesByFolderId.first.folderName!), centerTitle: true),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: widget.coursesByFolderId.length,
        itemBuilder: (context, index) {
          final itemTemp = widget.coursesByFolderId[index];

          final item = widget.allcourses.where((element) => "${element.courseId}" == itemTemp.courseId!).first;

          // return Text("data ${itemTemp.courseName} ${course.courseName}");
          return GestureDetector(
            onTap: () {
              // print("${controller.myCourses![index]}");
              appRoutes.pushNamed(PagesName.subjectDetailsPage, extra: item);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: AppColor.softBorderColor),
                borderRadius: BorderRadius.circular(4),
              ),
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
                            Text(
                              // "Mathematics",
                              item.courseName.toString(),
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
                            value: double.parse(getMyEnrollment(item.courseEnrollment!).progress!) / 100,
                            backgroundColor: AppColor.scaffoldBg,
                            color: context.appTheme.colorScheme.primary,
                            minHeight: 6,
                          ),
                        ),
                        16.width,
                        Text(
                          // "10%",
                          // "${controller.getMyEnrollment(index).progress}%",
                          "${int.parse(getMyEnrollment(item.courseEnrollment!).progress!)}%",
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
          );
        },
        separatorBuilder: (context, index) => 16.height,
      ),
    );
  }

  CoursesEnrollment getMyEnrollment(List<CoursesEnrollment> enrollments) {
    final myEnrol = enrollments.where((element) => element.userId == AppStorage.user.currentUser()?.userid.toString()).first;

    return myEnrol;
  }
}
