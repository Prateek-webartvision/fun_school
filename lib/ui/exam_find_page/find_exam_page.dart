// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/const.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../models/exams/exams_models/all_exam_model.dart';
import '../../style/color.dart';
import '../exam_preparation_page/controller/find_exam_crontroller.dart';
import 'tabs/certificate_exam_tab.dart';

class FindExamPage extends StatefulWidget {
  const FindExamPage({super.key, required this.allExams, required this.crontroller, required this.title});
  final List<AllExamModel> allExams;
  final FindExamCrontroller crontroller;
  final String title;

  @override
  State<FindExamPage> createState() => _FindExamPageState();
}

class _FindExamPageState extends State<FindExamPage> with TickerProviderStateMixin {
  late TabController tabController;
  late final List<String?> catBtnSet;

  @override
  void initState() {
    catBtnSet = widget.allExams.map((e) => e.examSubCategoryName).toSet().toList();
    tabController = TabController(length: catBtnSet.length, vsync: this);
    widget.crontroller.groupAllExamByName(allExams: widget.allExams);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        // title: const Text("Find Exams"),
        title: Text(widget.title),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))],
      ),
      body: GetBuilder(
        init: widget.crontroller,
        builder: (cnt) {
          return Column(
            //       // padding: EdgeInsets.all(16),
            children: [
              16.height,
              // Tab Bar
              AnimatedBuilder(
                animation: tabController,
                builder: (context, child) {
                  return SizedBox(
                    height: 50,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: catBtnSet.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: KBtn(
                            height: 44,
                            bgColor: (tabController.index == index) ? AppColor.mainColor : AppColor.white,
                            fbColor: (tabController.index == index) ? AppColor.white : Colors.black,
                            text: catBtnSet[index] ?? "",
                            // text: "Past Questions",
                            onClick: () {
                              if (tabController.index != index) {
                                tabController.index = index;
                              }
                            },
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => 10.width,
                    ),
                  );
                },
              ),
              // Tab Bar view
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: catBtnSet.map((e) {
                    // flilter exams
                    final filterExams = cnt.getExamsBySubCategories(allExam: cnt.sortedAllExam!, subCat: e!);

                    return PastQuestionsTab(
                      allExams: filterExams,
                      crontroller: widget.crontroller,
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
