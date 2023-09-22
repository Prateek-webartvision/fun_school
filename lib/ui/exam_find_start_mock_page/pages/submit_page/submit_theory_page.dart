// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/exams/exams_models/theory_question_model.dart';
import '../../../../style/const.dart';
import '../../controller/theory_answer_controller.dart';
import '../../widgets/head_question.dart';

class TheorySumbmitPage extends StatefulWidget {
  const TheorySumbmitPage({super.key, required this.questions, required this.title});
  final List<TheoryQuestionModel> questions;
  final String title;

  @override
  State<TheorySumbmitPage> createState() => _TheorySumbmitPageState();
}

class _TheorySumbmitPageState extends State<TheorySumbmitPage> {
  late TheoryAnswerController answerController;
  TextEditingController answerText = TextEditingController();
  @override
  void initState() {
    answerController = TheoryAnswerController(questions: widget.questions);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        title: Text("${widget.title} Questions"),
        centerTitle: true,
        surfaceTintColor: AppColor.white,
      ),
      body: GetBuilder(
        init: answerController,
        builder: (controller) {
          return Column(
            children: [
              HeadQuestion(
                totalQ: controller.questions.length,
                currentQ: controller.index + 1,
                question: controller.questions[controller.index].question ?? "",
                points: int.parse(controller.questions[controller.index].points ?? "0"),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: TextField(
                      controller: answerText,
                      maxLines: 20,
                      minLines: 20,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: "Write the solution to the question here…",
                        filled: true,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.all(12),
                        fillColor: AppColor.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColor.softBorderColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColor.softBorderColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )

              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //   ),
              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //               color: AppColor.scaffoldBg,
              //               borderRadius: BorderRadius.circular(100),
              //               border: Border.all(color: Colors.black),
              //             ),
              //             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              //             child: Text(
              //               "Question 1",
              //               style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ),
              //           //
              //           Container(
              //             decoration: BoxDecoration(
              //               color: AppColor.scaffoldBg,
              //               borderRadius: BorderRadius.circular(100),
              //               border: Border.all(color: Colors.black),
              //             ),
              //             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              //             child: Text(
              //               "100 point",
              //               style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       12.height,
              //       //
              //       Text(
              //         "Write Essay About Artifial Intelegence",
              //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              //       ),
              //       12.height,
              //       Container(
              //         height: 193,
              //         decoration: BoxDecoration(
              //           color: AppColor.scaffoldBg,
              //           image: DecorationImage(
              //             image: AssetImage(AppAssets.startExamTextBg),
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // 14.height,
              // //
              // Container(
              //   decoration: BoxDecoration(
              //     color: AppColor.white,
              //     border: Border.all(color: AppColor.softBorderColor),
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   margin: EdgeInsets.symmetric(horizontal: 16),
              //   padding: const EdgeInsets.all(12),
              //   child: Column(
              //     children: [
              //       Container(
              //         height: 32,
              //         width: 32,
              //         decoration: BoxDecoration(color: AppColor.mainColor, borderRadius: BorderRadius.circular(30)),
              //         alignment: Alignment.center,
              //         child: SvgPicture.asset(AppAssets.svg.uploadIcon),
              //       ),
              //       10.height,
              //       Text(
              //         "Upload Answers PDF",
              //         style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              //       )
              //     ],
              //   ),
              // ),
              // 12.height, // attech file name
              // ListView(
              //   shrinkWrap: true,
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             SvgPicture.asset(AppAssets.svg.attachment2Icon),
              //             4.width,
              //             Text(
              //               "Essay-ahamd.pdf",
              //               style: TextStyle(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w700,
              //                 color: AppColor.mainColor,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Icon(Icons.close, size: 20),
              //       ],
              //     )
              //   ],
              // )
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: KBtn(
          height: 44,
          onClick: () {
            if (answerText.text.isNotEmpty) {
              answerController.setAnswerAndNext(answerText);
            } else {
              AppUtils.showSnack("give you answer");
            }
          },
          text: "Next",
        ),
      ),
    );
  }
}
