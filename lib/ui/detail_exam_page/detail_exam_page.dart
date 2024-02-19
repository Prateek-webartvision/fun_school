// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/style/const.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';
import '../../widgets/k_btn.dart';
import '../exam_certificate_start_pages/start_exam_page/start_exam_page.dart';
import 'controllers/year_controller.dart';
import 'widgets/exam_details_tile.dart';

class DetailCertificateExamPage extends StatefulWidget {
  const DetailCertificateExamPage({super.key});

  @override
  State<DetailCertificateExamPage> createState() =>
      _DetailCertificateExamPageState();
}

class _DetailCertificateExamPageState extends State<DetailCertificateExamPage> {
  List<String> years = ["2009", "2020", "2021", "2022", "2023"];
  late YearSelectorController yearSelectorController;

  @override
  void initState() {
    yearSelectorController = YearSelectorController(initIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    yearSelectorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        titleTextStyle: AppTextStyle.appBarText,
        title: Text("JAMB"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // top btns
          Row(
            children: [
              Expanded(child: KBtn(onClick: () {}, text: "Actual Past")),
              12.width,
              Expanded(
                child: KBtn(
                  bgColor: AppColor.white,
                  fbColor: Colors.black,
                  text: "Sample Exam",
                  onClick: () {},
                ),
              ),
            ],
          ),
          12.height,
          // message
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Actual Past Exams",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              Text(
                "The Joint Admissions and Matriculation Board Exam Real Past questions",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          12.height,
          // year selector
          SizedBox(
            height: 30,
            child: GetBuilder(
              init: yearSelectorController,
              builder: (controller) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: years.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.changeIndex(index);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          color: (controller.index == index)
                              ? AppColor.mainColor
                              : AppColor.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.center,
                        child: Text(
                          years[index],
                          style: TextStyle(
                              color: (controller.index != index)
                                  ? AppColor.darkTextColor
                                  : AppColor.white),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 10.width,
                );
              },
            ),
          ),
          12.height,
          //exam
          ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              ExamDetailsTile(
                completeState: 1,
                onClick: () {
                  // appRoutes.pushNamed(PagesName.startExamPage);
                  rootNavigator.currentState!
                      .push(MaterialPageRoute(builder: (_) => StartExamPage()));
                  // print("object ${appRoutes.location}");
                },
              ),
              12.height,
              ExamDetailsTile(completeState: 2),
              12.height,
              ExamDetailsTile(completeState: 3),
            ],
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       color: AppColor.white,
      //       padding: EdgeInsets.symmetric(horizontal: 16),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           14.height,
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "JAMB",
      //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      //               ),
      //               Container(
      //                 height: 48,
      //                 width: 48,
      //                 decoration: BoxDecoration(
      //                   color: AppColor.white,
      //                   borderRadius: BorderRadius.circular(48),
      //                   border: Border.all(color: AppColor.softBorderColor),
      //                   boxShadow: [
      //                     BoxShadow(
      //                       color: Color(0x0F101828),
      //                       offset: Offset(0, 1),
      //                       blurRadius: 2,
      //                     ),
      //                     BoxShadow(
      //                       color: Color(0x1A101828),
      //                       offset: Offset(0, 1),
      //                       blurRadius: 3,
      //                     ),
      //                   ],
      //                 ),
      //                 alignment: Alignment.center,
      //                 child: Icon(
      //                   Icons.add_rounded,
      //                   color: AppColor.mainColor,
      //                   size: 24,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           14.height,
      //           SizedBox(
      //             height: 28,
      //             child: TabBar(
      //               labelPadding: EdgeInsets.only(right: 24),
      //               controller: pageTabController,
      //               isScrollable: true,
      //               indicatorSize: TabBarIndicatorSize.label,
      //               splashFactory: NoSplash.splashFactory,
      //               dividerColor: Colors.transparent,
      //               unselectedLabelColor: AppColor.unSelectedTapColor,
      //               tabs: const [
      //                 Tab(text: "Real"),
      //                 Tab(text: "Past"),
      //                 Tab(text: "Practice"),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),

      //     //body
      //     Expanded(
      //         child: TabBarView(
      //       controller: pageTabController,
      //       children: [
      //         _RealTabView(),
      //         _RealTabView(),
      //         _RealTabView(),
      //       ],
      //     ))
      //   ],
      // ),
    );
  }
}

// class _RealTabView extends StatelessWidget {
//   // const _RealTabView({
//   //   super.key,
//   // });

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(16),
//       children: [
//         ExamDetailsTile(
//           completeState: 1,
//           onClick: () {
//             // appRoutes.pushNamed(PagesName.startExamPage);
//             // print("object ${appRoutes.location}");
//           },
//         ),
//         12.height,
//         ExamDetailsTile(completeState: 2),
//         12.height,
//         ExamDetailsTile(completeState: 3),
//       ],
//     );
//   }
// }
