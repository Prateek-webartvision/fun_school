// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'controller/home_page_controller.dart';
import 'controller/smooth_indicator_controller.dart';
import 'widgets/course_slider_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageTipController homePageTipController;
  late SmoothIndicatorController smoothIndicatorController;
  late SmoothIndicatorController smoothIndicatorTipController;

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
      title: "Find courses by career",
      subTitle: "Search using your career aspirations",
      onClick: () {
        appRoutes.pushNamed(PagesName.findCourseByCareerPage);
      },
    ),
    CourseSliderTile(
      assetImage: "assets/img/home_images/Interest.jpg",
      title: "Find Courses by interest",
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
    smoothIndicatorTipController = SmoothIndicatorController(0);
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
            // return Center(child: Text(controller.error.toString()));
            return ErrorPage(
                error: controller.error.toString(),
                onError: () {
                  // Reload method here
                  controller.reloadTips();
                });
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
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              final item = controller.tips![index];
                              return Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: AppColor.softBorderColor),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                clipBehavior: Clip.hardEdge,
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.tipTitle ?? "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    4.height,
                                    Text(
                                      item.tipContent ?? "",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
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
                                smoothIndicatorTipController.changeIndex(index);
                              },
                            ),
                          ),
                          8.height,
                          AnimatedBuilder(
                            animation: smoothIndicatorTipController,
                            builder: (context, child) {
                              return Align(
                                alignment: Alignment.center,
                                child: AnimatedSmoothIndicator(
                                  effect: WormEffect(
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    activeDotColor: AppColor.mainColor,
                                    dotColor:
                                        AppColor.mainColor.withOpacity(0.3),
                                  ),
                                  activeIndex:
                                      smoothIndicatorTipController.currentIndex,
                                  count: controller.tips!.length,
                                ),
                              );
                            },
                          ),
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
