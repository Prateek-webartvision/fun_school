// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/style/const.dart';
import 'package:citycloud_school/ui/exam_certificate_start_pages/result_page/result_page.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../models/exams/exams_models/multi_choice_quetion_model.dart';
import '../../../../widegts/k_btn.dart';
import '../../widgets/head_question.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({super.key, required this.questions, required this.initIndex, required this.title});
  final String title;
  final int initIndex;
  final List<MultiChoiceQuestion> questions;

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  late QuestionAnswerController answerController;
  List<String> questions = [
    "A name that refers to a value",
    "A name that refers to a literal",
    "A programming-language representation of a value",
    "A statement that associates a variable with a type",
    "None of the above"
  ];

  @override
  void initState() {
    answerController = QuestionAnswerController(initIndex: widget.initIndex, questions: widget.questions);
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
                points: int.parse(controller.questions[controller.index].points ?? "0"),
              ),
              // answer card

              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  itemCount: controller.questions[controller.index].questionAnswers!.length,
                  itemBuilder: (context, index) {
                    final data = controller.questions[controller.index];
                    final op = data.questionAnswers![index];
                    return AnswerSelectorTile(
                      seletedAns: data.selectedAnswer,
                      // questions: questions,
                      op: op,
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
                    builder: (_) => ResultPage(),
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

class AnswerSelectorTile extends StatelessWidget {
  const AnswerSelectorTile({
    super.key,
    this.seletedAns,
    required this.op,
    required this.onClick,
  });

  final String? seletedAns;
  final String op;
  final Function(String? v) onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(op),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: (seletedAns == op) ? Border.all(color: AppColor.pinkColor) : null,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.only(right: 16, top: 4, bottom: 4),
        child: Row(
          children: [
            Radio<String?>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: AppColor.pinkColor,
              value: op,
              groupValue: seletedAns,
              onChanged: onClick,
              // onChanged: (value) {
              //   print(value);
              //   // setState(() {
              //   //   seletedAns = questions[index];
              //   // });
              // },
            ),
            Expanded(
              child: Text(
                op,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionAnswerController extends GetxController {
  final List<MultiChoiceQuestion> questions;
  late int index;

  QuestionAnswerController({required int initIndex, required this.questions}) {
    index = initIndex;
  }

  next({
    required void Function() onEnd,
    required void Function() onAnsNotSelected,
  }) {
    if (questions[index].selectedAnswer == null) {
      onAnsNotSelected();
    } else if (index < (questions.length - 1)) {
      index++;
      update();
    } else {
      onEnd();
    }
  }

  selectAnswer({required MultiChoiceQuestion obj, required String ans}) {
    if (obj.selectedAnswer != ans) {
      obj.selectedAnswer = ans;
      update();
    }
  }

  @override
  void dispose() {
    for (var element in questions) {
      element.selectedAnswer = null;
    }
    super.dispose();
  }
}
