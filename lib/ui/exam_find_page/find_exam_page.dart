// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/const.dart';
import 'package:citycloud_school/style/theme.dart';
import 'package:citycloud_school/ui/detail_exam_page/detail_exam_page.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../router/app_router.dart';
import '../../style/color.dart';
import '../../uitls/app_utils.dart';
import 'widgets/find_exam_tile.dart';

class FindExamPage extends StatefulWidget {
  const FindExamPage({super.key});

  @override
  State<FindExamPage> createState() => _FindExamPageState();
}

class _FindExamPageState extends State<FindExamPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        title: const Text("Find Exams"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))],
      ),
      body: Column(
        // padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
            child: AnimatedBuilder(
              animation: tabController,
              builder: (context, child) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: KBtn(
                            bgColor: (tabController.index == 0) ? AppColor.mainColor : AppColor.white,
                            fbColor: (tabController.index == 0) ? AppColor.white : Colors.black,
                            text: "Certificate Exams",
                            onClick: () {
                              if (tabController.index != 0) {
                                tabController.index = 0;
                              }
                            },
                          ),
                        ),
                        12.width,
                        Expanded(
                          child: KBtn(
                            bgColor: (tabController.index == 1) ? AppColor.mainColor : AppColor.white,
                            fbColor: (tabController.index == 1) ? AppColor.white : Colors.black,
                            text: "Mock Exams",
                            onClick: () {
                              if (tabController.index != 1) {
                                tabController.index = 1;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    12.height,
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                CertificateExamTab(),
                MockExamTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MockExamTab extends StatelessWidget {
  const MockExamTab({
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
            12.height,
            ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                ExamSubjectTile(
                  title: "Mathematics",
                  editions: 30,
                ),
                8.height,
                ExamSubjectTile(
                  title: "English Literature",
                  editions: 30,
                ),
              ],
            )
          ],
        ),
        12.height,
      ],
    );
  }
}

class ExamSubjectTile extends StatelessWidget {
  const ExamSubjectTile({
    super.key,
    required this.title,
    required this.editions,
    this.onTap,
  });
  final String title;
  final int editions;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: AppShadow.boxShadow,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            "$editions Edtition",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

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
            Text("Certificate Exams",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
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
