// ignore_for_file: prefer_const_constructors

import 'package:fun_school/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_gif/flutter_gif.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:number_to_indian_words/number_to_indian_words.dart';

import '../../style/color.dart';
import '../../widgets/k_btn.dart';
import 'controller/quiz_controller.dart';
import '../start_quiz_pages/model/quiz_model.dart';

class QuizTabPage extends StatefulWidget {
  const QuizTabPage({
    super.key,
    required this.quizController,
    required this.subjectId,
    required this.courseId,
    required this.onCencel,
    required this.onSubmit,
  });
  final QuizController quizController;
  final String subjectId;
  final String courseId;
  final Function() onCencel;
  final Function() onSubmit;

  @override
  State<QuizTabPage> createState() => _QuizTabPageState();
}

class _QuizTabPageState extends State<QuizTabPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: widget.quizController,
      builder: (controller) {
        var quiz = controller.quizs![controller.currentQuizIndex];
        return Scaffold(
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.softBorderColor),
                  // borderRadius: BorderRadius.circular(4),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // bar
                    LinearProgressIndicator(
                        value: (controller.currentQuizIndex + 1) /
                            controller.quizs!.length,
                        minHeight: 6),
                    14.height,
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColor.mainColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            "Mission ${NumToWords.convertNumberToIndianWords(controller.misstionIdex)}"
                                .capitalize!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          6.height,
                          Text(
                            quiz.missionText ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //       // height: 24,
                    //       decoration: BoxDecoration(
                    //         color: AppColor.scaffoldBg,
                    //         borderRadius: BorderRadius.circular(100),
                    //         border: Border.all(color: Colors.black),
                    //       ),
                    //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    //       child: Text(
                    //         // "dsad",
                    //         "Question ${controller.currentQuizIndex + 1}/${controller.quizs!.length}",
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //         color: AppColor.scaffoldBg,
                    //         borderRadius: BorderRadius.circular(100),
                    //         border: Border.all(color: AppColor.textFeildBorderColor),
                    //       ),
                    //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    //       child: Text(
                    //         "1 point",
                    //         style: TextStyle(
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),

                    8.height,

                    // qustion
                    Text(
                      // "Look at the numbers. Drag and drop in their correct word.",
                      quiz.question ?? "",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),

              // dag options
              20.height,
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.softBorderColor),
                  // borderRadius: BorderRadius.circular(4),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Row(children: [
                  // Text(quiz.sideImage.runtimeType.toString()),
                  Expanded(
                      flex: 1,
                      child: (quiz.sideImage != null)
                          ? Image.network(quiz.sideImage!)
                          // KGifImage(url: quiz.sideImage!)

                          : Center(
                              child: Text("No Image"),
                            )),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: quiz.quizData!.length,
                        primary: false,
                        itemBuilder: (context, index) {
                          final item = quiz.quizData![index];
                          return Draggable<QuizData>(
                            data: item,
                            feedback: DragableTitle(
                              ans: item.correctAnswer!,
                            ),
                            // childWhenDragging: SizedBox(),
                            child: DragableTitle(
                              ans: item.correctAnswer!,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => 10.height,
                      ),
                    ),
                  )
                ]),
              ),

              20.height,
              // target

              ListView.separated(
                shrinkWrap: true,
                itemCount: quiz.quizData!.length,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return DragTarget<QuizData>(
                    onAccept: (data) {
                      controller.changeAns(
                          quizDataIndex: index,
                          selectedAns: data.correctAnswer!);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border.all(color: AppColor.softBorderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            text: quiz.quizData![index].question,
                            style: TextStyle(color: Colors.black),
                            children: (quiz.quizData![index].selectedAns !=
                                    null)
                                ? [
                                    TextSpan(text: " "),
                                    TextSpan(
                                        text:
                                            quiz.quizData![index].selectedAns!),
                                  ]
                                : [
                                    TextSpan(text: " "),
                                    TextSpan(text: "_________"),
                                  ],
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return 15.height;
                },
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: AppColor.white,
              //     border: Border.all(color: AppColor.softBorderColor),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   alignment: Alignment.center,
              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              //   margin: EdgeInsets.symmetric(horizontal: 16),
              //   child: ListView.separated(
              //     shrinkWrap: true,
              //     itemCount: quiz.quizData!.length,
              //     itemBuilder: (context, index) {
              //       return DragTarget<QuizData>(
              //         onAccept: (data) {
              //           controller.changeAns(quizDataIndex: index, selectedAns: data.correctAnswer!);
              //         },
              //         builder: (context, candidateData, rejectedData) {
              //           return Container(
              //             height: 40,
              //             // color: Colors.green,
              //             alignment: Alignment.centerLeft,
              //             child: RichText(
              //               text: TextSpan(
              //                   text: quiz.quizData![index].question,
              //                   style: TextStyle(color: Colors.black),
              //                   children: (quiz.quizData![index].selectedAns != null)
              //                       ? [
              //                           TextSpan(text: " "),
              //                           TextSpan(text: quiz.quizData![index].selectedAns!),
              //                         ]
              //                       : [
              //                           TextSpan(text: " "),
              //                           TextSpan(text: "_________"),
              //                         ]),
              //             ),
              //           );
              //         },
              //       );
              //     },
              //     separatorBuilder: (context, index) {
              //       return 0.height;
              //     },
              //   ),
              // ),
            ],
          ),
          bottomNavigationBar: GetBuilder(
            init: widget.quizController,
            builder: (controller) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: KBtn(
                        height: 44,
                        onClick: widget.onCencel,
                        text: "Cancel",
                        bgColor: AppColor.white,
                        fbColor: Colors.black,
                        borderSide: BorderSide(color: AppColor.softBorderColor),
                      ),
                    ),
                    12.width,
                    Expanded(
                        child: KBtn(
                      onClick: () {
                        // check all answers are given
                        var d = controller
                            .quizs![controller.currentQuizIndex].quizData!
                            .where((element) => element.selectedAns == null)
                            .toList();
                        if (d.isNotEmpty) {
                          AppUtils.showSnack("Fill All answers");
                        } else if ((controller.quizs!.length - 1) >
                            controller.currentQuizIndex) {
                          controller.goToNextQuitions();
                        } else {
                          // submit
                          widget.onSubmit();
                        }
                      },
                      text: "Next",
                      height: 44,
                    )),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class DragableTitle extends StatelessWidget {
  const DragableTitle({
    super.key,
    required this.ans,
  });
  final String ans;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 107,
        height: 40,
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.softBorderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          // "100",
          ans,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// class KGifImage extends StatefulWidget {
//   const KGifImage({super.key, required this.url});
//   final String url;

//   @override
//   State<KGifImage> createState() => _KGifImageState();
// }

// class _KGifImageState extends State<KGifImage> with SingleTickerProviderStateMixin {
//   late FlutterGifController gifController;

//   @override
//   void initState() {
//     gifController = FlutterGifController(vsync: this);

//     super.initState();
//   }

//   _loadFrame() async {
//     final url = Uri.parse(widget.url);
//     final ByteData data = await NetworkAssetBundle(url).load(url.path);

//     await _extractGifFrames(data).then((e) {
//       gifController.repeat(min: 0, max: e.toDouble(), period: const Duration(seconds: 1));
//     });
//   }

//   // Function to extract gif image frames
//   Future<int> _extractGifFrames(ByteData data) async {
//     // Create a codec to decode the gif
//     final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());

//     final int frameCount = codec.frameCount;

//     return frameCount;
//   }

//   @override
//   void dispose() {
//     gifController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GifImage(
//       fit: BoxFit.cover,
//       image: NetworkImage(widget.url),
//       controller: gifController,
//       repeat: ImageRepeat.repeat,
//       onFetchCompleted: () {
//         gifController.value = 0;
//         gifController.stop();
//         _loadFrame();
//       },
//     );
//   }
// }
