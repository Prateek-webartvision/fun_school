// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/exams/exams_models/all_exam_model.dart';
import '../../../router/app_router.dart';
import '../../exam_find_mock_page/exam_find_mock_page.dart';
import '../../exam_preparation_page/controller/find_exam_controller.dart';
import '../widgets/exam_subject_tile.dart';

class PastQuestionsTab extends StatelessWidget {
  const PastQuestionsTab({
    super.key,
    required this.allExams,
    required this.crontroller,
  });
  final List<List<AllExamModel>> allExams;
  final FindExamController crontroller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // message
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Past Questions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Real past questions by the examination council",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        12.height,
        //body

        if (allExams.isEmpty)
          Center(child: Text("No Exams"))
        else
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: allExams.length,
            itemBuilder: (context, index) {
              final exam = allExams[index];
              return ExamSubjectTile(
                // title: "English Literature",
                title: exam.first.examCourseName ?? "N/A",
                editions: exam.length,

                onClick: () {
                  // rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => DetailCertificateExamPage()));

                  MaterialPageRoute examFindEditionPage = MaterialPageRoute(
                    builder: (_) =>
                        ExamFindEditions(exam: exam, crontroller: crontroller),
                  );
                  rootNavigator.currentState!.push(examFindEditionPage);
                },
              );
            },
            separatorBuilder: (context, index) => 20.height,
          ),

        // Column(
        //   children: List.generate(allExams.length, (index) {
        //               // final exam = widget.allExams[index];
        //               return Column(
        //             children: [
        //               ExamSubjectTile(
        //                 // title: "English Literature",
        //                 title: exam.examCourseName ?? "N/A",
        //                 editions: int.parse(exam.examEdition ?? "0"),

        //                 onClick: () {
        //                   // rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => DetailCertificateExamPage()));

        //                   //

        //                   MaterialPageRoute examFindEditionPage = MaterialPageRoute(
        //                     builder: (_) => ExamFindEditions(exam: exam, crontroller: widget.crontroller),
        //                   );
        //                   rootNavigator.currentState!.push(examFindEditionPage);
        //                   //
        //                 },
        //               ),
        //               if (index < widget.allExams.length - 1) 12.height,
        //             ],
        // );
        // }),
        // ),
        //     // exmans
        //     // FindExamTile(
        //     //   title: "JAMB",
        //     //   color: Color(0xff6519BA),
        //     //   onClick: () {
        //     //     // appRoutes.pushNamed(PagesName.detailExamPage);
        //     //     rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => DetailCertificateExamPage()));
        //     //   },
        //     // ),
        //     // 12.height,
        //     // FindExamTile(
        //     //   title: "WAEC",
        //     //   color: Color(0xffEF6F38),
        //     //   onClick: () {
        //     //     AppUtils.showSnack("coming soon");
        //     //   },
        //     // ),
        //     // 12.height,
        //     // FindExamTile(
        //     //   title: "SSCE",
        //     //   color: Color(0xff3897EF),
        //     //   onClick: () {
        //     //     AppUtils.showSnack("coming soon");
        //     //   },
        //     // ),
        //     // 12.height,
      ],
    );
  }
}
