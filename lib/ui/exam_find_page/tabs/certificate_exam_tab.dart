// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../router/app_router.dart';
import '../../../uitls/app_utils.dart';
import '../../detail_exam_page/detail_exam_page.dart';
import '../widgets/find_exam_tile.dart';

class CertificateExamTab extends StatelessWidget {
  const CertificateExamTab({
    super.key,
  });

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
              "Certificate Exams",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Dive deep into past questions or explore sample exams.",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        12.height,
        // exmans
        FindExamTile(
          title: "JAMB",
          color: Color(0xff6519BA),
          onClick: () {
            // appRoutes.pushNamed(PagesName.detailExamPage);
            rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => DetailExamPage()));
          },
        ),
        12.height,
        FindExamTile(
          title: "WAEC",
          color: Color(0xffEF6F38),
          onClick: () {
            AppUtils.showSnack("coming soon");
          },
        ),
        12.height,
        FindExamTile(
          title: "SSCE",
          color: Color(0xff3897EF),
          onClick: () {
            AppUtils.showSnack("coming soon");
          },
        ),
      ],
    );
  }
}
