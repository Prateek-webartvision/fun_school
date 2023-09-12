import 'package:flutter/material.dart';

import '../../style/const.dart';

class ExamStudyPlanDetailsPage extends StatefulWidget {
  const ExamStudyPlanDetailsPage({super.key});

  @override
  State<ExamStudyPlanDetailsPage> createState() => _ExamStudyPlanDetailsPageState();
}

class _ExamStudyPlanDetailsPageState extends State<ExamStudyPlanDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        title: const Text("JAMB 2023"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))],
      ),
    );
  }
}
