// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/subject.model.dart';
import '../../../router/app_router.dart';
import '../../../style/color.dart';
import '../../flash_card_page/flash_card_page.dart';

class ChaptersTab extends StatelessWidget {
  const ChaptersTab({
    super.key,
    this.subject,
  });
  final CoursesSubject? subject;

  @override
  Widget build(BuildContext context) {
    if (subject!.subjectContent!.isEmpty) {
      return Center(child: Text("No content to show"));
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: subject!.subjectContent!.length,
        itemBuilder: (context, index) {
          final chapter = subject!.subjectContent![index];

          return ChapterTile(
            title: chapter.first.title!,
            subjects: chapter,
          );
          // rootNavigator.currentState!.push(MaterialPageRoute(builder: (context) => FlashCardPage()));
        },
        separatorBuilder: (context, index) => 12.height,
      );
    }
  }
}

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    super.key,
    required this.title,
    required this.subjects,
  });
  final String title;
  final List<SubjectContent> subjects;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        rootNavigator.currentState!.push(MaterialPageRoute(builder: (context) => FlashCardPage()));
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
              height: 44,
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
                        // "Solving equations & inequalities",
                        title,
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
            // List of similer subjects with diffrent sub title
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return Row(
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
                );
              },
              separatorBuilder: (context, index) => 16.height,
            ),
            10.height,
          ],
        ),
      ),
    );
  }
}
