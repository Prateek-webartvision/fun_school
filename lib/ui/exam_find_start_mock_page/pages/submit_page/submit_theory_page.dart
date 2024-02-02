// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/repo/exams/exams_repo.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/utils/app_utils.dart';
import 'package:citycloud_school/widgets/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/exams/exams_models/theory_question_model.dart';
import '../../../../style/const.dart';
import '../../controller/theory_answer_controller.dart';
import '../../widgets/head_question.dart';

class TheorySubmitPage extends StatefulWidget {
  const TheorySubmitPage(
      {super.key, required this.questions, required this.title});
  final List<TheoryQuestionModel> questions;
  final String title;

  @override
  State<TheorySubmitPage> createState() => _TheorySubmitPageState();
}

class _TheorySubmitPageState extends State<TheorySubmitPage> {
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
                points: int.parse(
                    controller.questions[controller.index].points ?? "0"),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: TextField(
                      controller: answerText,
                      maxLines: 20,
                      minLines: 20,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GetBuilder(
          init: answerController,
          builder: (controller) {
            return KBtn(
              height: 44,
              onClick: () async {
                if (answerText.text.isNotEmpty) {
                  final ans = controller.questions[controller.index];
                  await AppUtils.showLoadingOverlay(() async {
                    var vv = await ExamsRepository.submitTheoryExam(
                      examId: ans.examId!,
                      questionId: ans.questionId.toString(),
                      answer: answerText.text,
                    );
                    if (controller.index == (controller.questions.length - 1)) {
                      if (vv == true) {
                        AppUtils.showSnack("Thanku for submit your answer");
                      }
                    }
                  });
                  answerController.submitandAnswerAndNext(answerText);
                } else {
                  AppUtils.showSnack("give you answer");
                }
              },
              text: (controller.index >= (controller.questions.length - 1))
                  ? "Submit"
                  : "Next",
            );
          },
        ),
      ),
    );
  }
}
