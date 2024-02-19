// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fun_school/models/exams/exams_models/multi_choice_quetion_model.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/style/const.dart';
import 'package:fun_school/ui/exam_find_start_mock_page/pages/answers_page/answer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../widgets/question_view_tile.dart';

class QuestionViewPage extends StatefulWidget {
  const QuestionViewPage({super.key, required this.title, required this.questions});
  final String title;
  final List<MultiChoiceQuestion> questions;

  @override
  State<QuestionViewPage> createState() => _QuestionViewPageState();
}

class _QuestionViewPageState extends State<QuestionViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: AppTextStyle.appBarText),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 1,
        surfaceTintColor: context.theme.appBarTheme.backgroundColor,
        toolbarHeight: 48,
      ),

      //
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        // reverse: true,
        // shrinkWrap: true,
        itemCount: widget.questions.length,
        itemBuilder: (context, index) {
          final question = widget.questions[index];
          return QuestionViewTile(
            totalQ: widget.questions.length,
            // currentQ: int.parse(question.questionNo!),
            currentQ: index + 1,
            points: int.parse(question.points ?? "0"),
            question: widget.questions[index].question!,
            onClick: () {
              final answerPage = MaterialPageRoute(
                builder: (_) => AnswerPage(
                  title: widget.title,
                  initIndex: index,
                  questions: widget.questions,
                ),
              );
              rootNavigator.currentState!.push(answerPage);
            },
          );
        },
        separatorBuilder: (context, index) => 10.height,
      ),
    );
  }
}
