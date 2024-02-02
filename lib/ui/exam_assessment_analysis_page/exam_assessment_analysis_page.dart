// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/const.dart';
import '../../widgets/amswers_tile.dart';
import 'controller/analysis_chip_controller.dart';
import 'widgets/analysis_chip_view.dart';

class ExamAssessmentAnalysisPage extends StatefulWidget {
  const ExamAssessmentAnalysisPage({super.key});

  @override
  State<ExamAssessmentAnalysisPage> createState() =>
      _ExamAssessmentAnalysisPageState();
}

class _ExamAssessmentAnalysisPageState
    extends State<ExamAssessmentAnalysisPage> {
  late AnalysisChipController chipController;
  List<String> chips = [
    "Algebra",
    "Geometry",
    "Trigonometry",
    "Calculus",
  ];

  @override
  void initState() {
    chipController = AnalysisChipController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("View Question Analysis"),
        titleTextStyle: AppTextStyle.appBarText,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        primary: false,
        children: [
          // tag selector
          AnalysisChipView(
            controller: chipController,
            chips: chips,
          ),
          12.height,
          //
          ListView(
            shrinkWrap: true,
            children: [
              AnswersTile(
                currentQuestion: 1,
                totalQuestions: 3,
                question:
                    "In a right triangle, if one leg measures 3 units and the hypotenuse measures 5 units, how long is the other leg?",
                otherText: "i6a: + 4",
                isCorrect: true,
              ),
              12.height,
              AnswersTile(
                currentQuestion: 2,
                totalQuestions: 3,
                question:
                    "If a shirt costs \$40 after a 20% discount, what was its original price?",
                otherText: "Study Hours Required",
                isCorrect: true,
              ),
              12.height,
              AnswersTile(
                currentQuestion: 3,
                totalQuestions: 3,
                question: "Of the following, which best describes a variable?",
                otherText: "English Literature Quiz - Poetry Section",
                isCorrect: false,
              ),
            ],
          )
        ],
      ),
    );
  }
}
