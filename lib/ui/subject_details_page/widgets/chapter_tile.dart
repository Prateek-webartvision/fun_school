// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/ui/subject_video_list_page/subject_video_list_page.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/courses.model.dart';
import '../../../models/courses_dedails/subject.model.dart';
import '../../../router/app_router.dart';
import '../../../style/color.dart';

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    super.key,
    required this.title,
    required this.subjects,
    required this.videos,
    this.subjectId,
    this.enrollmentData,
    required this.courseId,
    required this.missionIndex,
  });
  final String title;
  final String courseId;
  final List<SubjectContent> subjects;
  final List<ContentVideo> videos;
  final int? subjectId;
  final List<CoursesEnrollment>? enrollmentData;
  final int missionIndex;

  List<ContentVideo> getBelowVideos(int index) {
    final topicSet = subjects.map((e) => e.subTitle).toList();

    int detIndex = topicSet.indexOf(subjects[index].subTitle);
    List<ContentVideo> belowVideos = [];

    for (int i = detIndex; i < topicSet.length; i++) {
      videos.where((element) => element.subTitle! == topicSet[i]).toList().forEach((e) {
        belowVideos.add(e);
      });
    }
    return belowVideos;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.softBorderColor),
        borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
      ),
      child: Column(
        children: [
          //top
          Container(
            height: 44,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      // "Solving equations & inequalities",
                      text: title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
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
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),

          // List of similer subjects with diffrent sub title
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (AppUtils.isCourseEnroledByMe(enrolls: enrollmentData!)) {
                    final v = getBelowVideos(index);

                    if (v.isEmpty) {
                      AppUtils.showSnack("No Videos");
                    } else {
                      rootNavigator.currentState!.push(
                        MaterialPageRoute(
                          builder: (context) => SubjectVideoListPage(
                            videos: v,
                            subjectId: subjectId,
                            contentTitle: subjects[index].title!,
                            courseID: courseId,
                            missionIndex: missionIndex,
                          ),
                        ),
                      );
                    }
                  } else {
                    AppUtils.showSnack("First Enroll The Course");
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.play_circle_fill_rounded,
                      color: AppColor.mainColor,
                      size: 20,
                    ),
                    4.width,
                    Text(
                      // "Overview and history algebra",
                      subjects[index].subTitle!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => 16.height,
          ),
          10.height,
        ],
      ),
    );
  }
}
