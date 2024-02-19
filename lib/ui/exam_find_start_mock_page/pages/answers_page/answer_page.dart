// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/style/color.dart';
import 'package:fun_school/style/const.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../models/exams/exams_models/multi_choice_quetion_model.dart';
import '../../../../widgets/k_btn.dart';
import '../../controller/question_answer_controller.dart';
import '../../widgets/answer_selector_tile.dart';
import '../../widgets/head_question.dart';
import '../result_page/find_exam_result_page.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage(
      {super.key,
      required this.questions,
      required this.initIndex,
      required this.title});
  final String title;
  final int initIndex;
  final List<MultiChoiceQuestion> questions;

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  late QuestionAnswerController answerController;

  @override
  void initState() {
    answerController = QuestionAnswerController(
        initIndex: widget.initIndex, questions: widget.questions);
    super.initState();
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text(
          "${widget.title} Questions",
          style: AppTextStyle.appBarText,
        ),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: answerController,
        builder: (controller) {
          return Column(
            children: [
              HeadQuestion(
                totalQ: controller.questions.length,
                currentQ: controller.index + 1,
                question: controller.questions[controller.index].question!,
                points: int.parse(
                    controller.questions[controller.index].points ?? "0"),
              ),
              // answer card

              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  itemCount: controller
                      .questions[controller.index].questionAnswers!.length,
                  itemBuilder: (context, index) {
                    final data = controller.questions[controller.index];
                    final op = data.questionAnswers![index];
                    return AnswerSelectorTile(
                      seletedAns: data.selectedAnswer,
                      options: op,
                      onClick: (v) {
                        if (v != null) {
                          controller.selectAnswer(obj: data, ans: v);
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) => 10.height,
                ),
              )
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: KBtn(
          onClick: () {
            answerController.next(
              onAnsNotSelected: () {
                AppUtils.showSnack("Select answer");
              },
              onEnd: () {
                rootNavigator.currentState!.pushReplacement(
                  MaterialPageRoute(
                    builder: (_) =>
                        FindExamResultPage(controller: answerController),
                  ),
                );
              },
            );
          },
          text: "Next",
          height: 44,
        ),
      ),
    );
  }
}
