// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'controller/home_page_controller.dart';
import 'widgets/course_slider_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageTipController homePageTipController;
  late SmoothIndicatorController smoothIndicatorController;
  List<CourseSliderTile> courseSliderData = [
    CourseSliderTile(
      assetImage: "assets/img/home_images/School.jpg",
      title: "Find courses by school",
      subTitle: "search by primary, secondary or tertiary institutions",
      onClick: () {
        appRoutes.pushNamed(PagesName.findCoursesBySchoolPage);
      },
    ),
    CourseSliderTile(
      assetImage: "assets/img/home_images/Career.jpg",
      title: "Find course by career",
      subTitle: "Search using your career aspirations",
      onClick: () {
        appRoutes.pushNamed(PagesName.findCourseByCareerPage);
      },
    ),
    CourseSliderTile(
      assetImage: "assets/img/home_images/Interest.jpg",
      title: "Find Course by interest",
      subTitle: "Find out how to code, design and lots more",
      onClick: () {
        appRoutes.pushNamed(PagesName.findCourseByInterestPage);
      },
    ),
    CourseSliderTile(
      assetImage: "assets/img/home_images/Exam.jpg",
      title: "Prepare for an Exam",
      subTitle: "Find popular exam questions and more",
      onClick: () {
        appRoutes.pushNamed(PagesName.prepareForAnExamPage);
      },
    ),
  ];

  @override
  void initState() {
    homePageTipController = HomePageTipController();
    smoothIndicatorController = SmoothIndicatorController(0);
    super.initState();
  }

  @override
  void dispose() {
    homePageTipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: homePageTipController,
        builder: (controller) {
          if (controller.apiState == ApiState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.apiState == ApiState.error) {
            return Center(child: Text(controller.error.toString()));
          } else {
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Find a course and start learning",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                16.height,

                CarouselSlider(
                  items: courseSliderData,
                  options: CarouselOptions(
                    initialPage: 0,
                    aspectRatio: 1,
                    viewportFraction: 1,
                    height: 280,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      smoothIndicatorController.changeIndex(index);
                    },
                  ),
                ),
                8.height,
                AnimatedBuilder(
                  animation: smoothIndicatorController,
                  builder: (context, child) {
                    return Align(
                      alignment: Alignment.center,
                      child: AnimatedSmoothIndicator(
                        effect: WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: AppColor.mainColor,
                          dotColor: AppColor.mainColor.withOpacity(0.3),
                        ),
                        activeIndex: smoothIndicatorController.currentIndex,
                        count: courseSliderData.length,
                      ),
                    );
                  },
                ),

                // Container(
                //   decoration: BoxDecoration(
                //     color: AppColor.white,
                //     borderRadius: BorderRadius.circular(4),
                //     border: Border.all(color: AppColor.softBorderColor),
                //   ),
                //   clipBehavior: Clip.hardEdge,
                //   child: Column(
                //     children: [
                //       //Find courses by school
                //       GestureDetector(
                //         onTap: () {
                //           appRoutes.pushNamed(PagesName.findCoursesBySchoolPage);
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.all(12),
                //           child: Row(
                //             children: [
                //               CircleAvatar(
                //                 radius: 20,
                //                 backgroundColor: Color(0xff6519BA),
                //                 child: Icon(
                //                   Icons.apartment_rounded,
                //                   color: AppColor.white,
                //                 ),
                //               ),
                //               10.width,
                //               Expanded(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       "Find courses by school",
                //                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                //                     ),
                //                     Text(
                //                       "search by primary, secondary or tertiary institutions",
                //                       style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               10.width,
                //               Icon(Icons.navigate_next_rounded)
                //             ],
                //           ),
                //         ),
                //       ),

                //       //Find course by career
                //       GestureDetector(
                //         onTap: () {
                //           appRoutes.pushNamed(PagesName.findCourseByCareerPage);
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.all(12),
                //           child: Row(
                //             children: [
                //               CircleAvatar(
                //                   radius: 20,
                //                   backgroundColor: Color(0xff6519BA),
                //                   child: Icon(
                //                     Icons.business_center_outlined,
                //                     color: AppColor.white,
                //                   )),
                //               10.width,
                //               Expanded(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       "Find course by career",
                //                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                //                     ),
                //                     Text(
                //                       "Search using your career aspirations",
                //                       style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               10.width,
                //               Icon(Icons.navigate_next_rounded)
                //             ],
                //           ),
                //         ),
                //       ),
                //       //Find Course by interest
                //       GestureDetector(
                //         onTap: () {
                //           appRoutes.pushNamed(PagesName.findCourseByInterestPage);
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.all(12),
                //           child: Row(
                //             children: [
                //               CircleAvatar(
                //                   radius: 20,
                //                   backgroundColor: Color(0xff6519BA),
                //                   child: Icon(
                //                     Icons.bolt_rounded,
                //                     color: AppColor.white,
                //                   )),
                //               10.width,
                //               Expanded(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       "Find Course by interest",
                //                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                //                     ),
                //                     Text(
                //                       "Find out how to code, design and lots more",
                //                       style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               10.width,
                //               Icon(Icons.navigate_next_rounded)
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // 16.height,

                // //Prepare For An Exam Page
                // Container(
                //   decoration: BoxDecoration(
                //     color: AppColor.white,
                //     borderRadius: BorderRadius.circular(4),
                //     border: Border.all(color: AppColor.softBorderColor),
                //   ),
                //   clipBehavior: Clip.hardEdge,
                //   child: Column(
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           appRoutes.pushNamed(PagesName.prepareForAnExamPage);
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.all(12),
                //           child: Row(
                //             children: [
                //               CircleAvatar(
                //                   radius: 20,
                //                   backgroundColor: Color(0xff6519BA),
                //                   child: Icon(
                //                     Icons.design_services_rounded,
                //                     color: AppColor.white,
                //                   )),
                //               10.width,
                //               Expanded(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       "Prepare for an Exam",
                //                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                //                     ),
                //                     Text(
                //                       "Find popular exam questions and more",
                //                       style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               10.width,
                //               Icon(Icons.navigate_next_rounded)
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                (controller.tips!.isNotEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.height,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Tip",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          10.height,
                          CarouselSlider.builder(
                            // items: courseSliderData,
                            itemCount: controller.tips!.length,
                            itemBuilder: (BuildContext context, int index, int realIndex) {
                              final item = controller.tips![index];
                              return Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColor.softBorderColor),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                clipBehavior: Clip.hardEdge,
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.tipTitle ?? "",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                    4.height,
                                    Text(
                                      item.tipContent ?? "",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 6,
                                    ),
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                              initialPage: 0,
                              aspectRatio: 1,
                              viewportFraction: 1,
                              height: 160,
                              enableInfiniteScroll: false,
                              autoPlay: false,
                              onPageChanged: (index, reason) {
                                smoothIndicatorController.changeIndex(index);
                              },
                            ),
                          ),
                          // ListView.separated(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   itemCount: controller.tips!.length,
                          //   itemBuilder: (context, index) {
                          //     final item = controller.tips![index];
                          //     return Container(
                          //       decoration: BoxDecoration(
                          //         color: AppColor.white,
                          //         borderRadius: BorderRadius.circular(4),
                          //         border: Border.all(color: AppColor.softBorderColor),
                          //       ),
                          //       clipBehavior: Clip.hardEdge,
                          //       padding: EdgeInsets.all(16),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             item.tipTitle ?? "",
                          //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                          //           ),
                          //           4.height,
                          //           Text(
                          //             item.tipContent ?? "",
                          //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                          //           ),
                          //         ],
                          //       ),
                          //     );
                          //   },
                          //   separatorBuilder: (context, index) => 6.height,
                          // )
                        ],
                      )
                    : SizedBox()
              ],
            );
          }
        },
      ),
    );
  }
}

class SmoothIndicatorController extends ChangeNotifier {
  late int currentIndex;
  SmoothIndicatorController(this.currentIndex);

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
