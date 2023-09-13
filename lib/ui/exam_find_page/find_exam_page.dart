// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/const.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import 'tabs/certificate_exam_tab.dart';
import 'tabs/mock_exam_tab.dart';

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
