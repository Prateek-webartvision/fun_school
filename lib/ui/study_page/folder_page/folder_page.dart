// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/network/data/app_storage.dart';
import 'package:citycloud_school/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_details/courses.model.dart';
import '../../../repo/study_plan_repo/study_plan_repo.dart';
import '../../../router/app_router.dart';
import '../../../router/pages.dart';
import '../../../style/color.dart';

class FolderPage extends StatefulWidget {
  const FolderPage(
      {super.key, required this.coursesByFolderId, required this.allCourses});
  final List<FolderCourseModel> coursesByFolderId;
  final List<CoursesModel> allCourses;

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  late FolderPageController folderPageController;

  @override
  void initState() {
    folderPageController =
        FolderPageController(coursesByFolderId: widget.coursesByFolderId);

    super.initState();
  }

  Future<bool> onPop() async {
    rootNavigator.currentState?.pop(folderPageController.isCourseRemoved);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onPop,
      child: Scaffold(
        appBar: AppBar(
            title: Text(widget.coursesByFolderId.first.folderName!),
            centerTitle: true),
        body: GetBuilder(
          init: folderPageController,
          builder: (controller) {
            if (controller.coursesByFolderId.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                rootNavigator.currentState?.pop(controller.isCourseRemoved);
              });
              // return Center(
              //   child: Text("No Courses"),
              // );
            }
            return ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: controller.coursesByFolderId.length,
              itemBuilder: (context, index) {
                final itemTemp = controller.coursesByFolderId[index];

                final item = widget.allCourses
                    .where((element) =>
                        "${element.courseId}" == itemTemp.courseId!)
                    .first;

                // return Text("data ${itemTemp.courseName} ${course.courseName}");
                return GestureDetector(
                  onTap: () {
                    appRoutes.pushNamed(PagesName.subjectDetailsPage,
                        extra: item);
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
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
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
                              ),
                              // time
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.scaffoldBg,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: AppColor.textFeildBorderColor),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Text(
                                  "1 hours",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              10.width,
                              PopupMenuButton(
                                child: Icon(Icons.more_vert_outlined),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: Text("Remove"),
                                      onTap: () {
                                        AppUtils.showLoadingOverlay(() async {
                                          await StudyPlanRepository
                                                  .removeCourseFromfolder(
                                                      courseId:
                                                          itemTemp.courseId!,
                                                      folderId:
                                                          itemTemp.folderId!)
                                              .then((value) {
                                            if (value != null) {
                                              controller.removeItem(itemTemp);
                                            }
                                          }).onError((error, stackTrace) {
                                            AppUtils.showSnack(
                                                error.toString());
                                          });
                                        });
                                      },
                                    ),
                                  ];
                                },
                              )
                            ],
                          ),
                        ),
                        //progress bar
                        Container(
                          // color: Colors.green,
                          height: 38,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
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
                                  value: double.parse(getMyEnrollment(
                                              item.courseEnrollment!)
                                          .progress!) /
                                      100,
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
            );
          },
        ),
      ),
    );
  }

  CoursesEnrollment getMyEnrollment(List<CoursesEnrollment> enrollments) {
    final myEnrol = enrollments
        .where((element) =>
            element.userId == AppStorage.user.currentUser()?.userId.toString())
        .first;

    return myEnrol;
  }
}

class FolderPageController extends GetxController {
  bool isCourseRemoved = false;
  late List<FolderCourseModel> coursesByFolderId;

  FolderPageController({required this.coursesByFolderId});

  removeItem(FolderCourseModel item) {
    coursesByFolderId.remove(item);
    isCourseRemoved = true;
    update();
  }
}
