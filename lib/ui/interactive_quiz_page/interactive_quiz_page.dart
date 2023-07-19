// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/models/quiz/interactive_quiz.model.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InteractiveQuizPage extends StatefulWidget {
  const InteractiveQuizPage({
    super.key,
    required this.quizModel,
  });
  final InteractiveQuizModel quizModel;

  @override
  State<InteractiveQuizPage> createState() => _InteractiveQuizPageState();
}

class _InteractiveQuizPageState extends State<InteractiveQuizPage> {
  late QuizPageController quizPageController;

  @override
  void initState() {
    quizPageController = QuizPageController(quizModel: widget.quizModel);
    super.initState();
  }

  @override
  void dispose() {
    quizPageController.dispose();
    super.dispose();
  }

  Future<bool> _onBack() async {
    bool canGoBack = false;
    if (quizPageController.currentQIndex < 1) {
      canGoBack = true;
    } else {
      quizPageController.prevQuiz();
    }

    // for (var element in quizPageController.quizModel.quizData!) {
    //   print(element.correctAnswer);
    // }

    return canGoBack;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: GetBuilder(
        init: quizPageController,
        builder: (controller) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.black.withOpacity(0.2),
              title: Text(controller.quizModel.title!.capitalize!),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                Image.network(
                  controller.quizModel.backgroundImage!,
                  height: double.maxFinite,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment(0, -0.7),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Mission",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          controller.quizModel.questionMissionText!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.brown,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      // "this is question",
                      controller.quizModel.quizData![controller.currentQIndex].question!,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: SizedBox(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setAns(ans: false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(120),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setAns(ans: true);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(120),
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizPageController extends GetxController {
  final InteractiveQuizModel quizModel;
  int currentQIndex = 0;
  // bool isQuizEnd = false;

  QuizPageController({required this.quizModel});

  setAns({required bool ans}) {
    quizModel.quizData![currentQIndex].copyWith(seletedAns: ans);

    if (currentQIndex < quizModel.quizData!.length - 1) {
      currentQIndex++;
    } else {
      // isQuizEnd = true;
      // rootNavigator.currentState!.pop<InteractiveQuizModel>(quizModel);
      bool allAndRight = false;
      for (var element in quizModel.quizData!) {
        if (element.correctAnswer == element.seletedAns) {
          allAndRight = true;
        } else {
          allAndRight = false;
          break;
        }
      }
      if (allAndRight) {
        rootNavigator.currentState!.pop<InteractiveQuizModel>(quizModel);
      } else {
        AppUtils.showSnack("Give right answer");
      }
    }

    update();
  }

  prevQuiz() {
    bool allAndRight = false;
    for (var element in quizModel.quizData!) {
      // print("${element.correctAnswer} == ${element.seletedAns}");
      if (element.correctAnswer == element.seletedAns) {
        allAndRight = true;
      } else {
        allAndRight = false;
        break;
      }
    }
    if (allAndRight == false) {
      currentQIndex--;
    } else {
      rootNavigator.currentState!.pop<InteractiveQuizModel>(quizModel);
    }
    update();
  }
}
