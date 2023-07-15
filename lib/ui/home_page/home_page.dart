// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/repo/tips/tips_repo.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import 'controller/home_page_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageTipController homePageTipController;

  @override
  void initState() {
    homePageTipController = HomePageTipController();
    super.initState();
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
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  "Find a course and start learning",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                16.height,
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColor.softBorderColor),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      //Find courses by school
                      GestureDetector(
                        onTap: () {
                          appRoutes.pushNamed(PagesName.findCoursesBySchoolPage);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xff6519BA),
                                child: Icon(
                                  Icons.apartment_rounded,
                                  color: AppColor.white,
                                ),
                              ),
                              10.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Find courses by school",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "search by primary, secondary or tertiary institutions",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              10.width,
                              Icon(Icons.navigate_next_rounded)
                            ],
                          ),
                        ),
                      ),

                      //Find course by career
                      GestureDetector(
                        onTap: () {
                          appRoutes.pushNamed(PagesName.findCourseByCareerPage);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0xff6519BA),
                                  child: Icon(
                                    Icons.business_center_outlined,
                                    color: AppColor.white,
                                  )),
                              10.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Find course by career",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Search using your career aspirations",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              10.width,
                              Icon(Icons.navigate_next_rounded)
                            ],
                          ),
                        ),
                      ),
                      //Find Course by interest
                      GestureDetector(
                        onTap: () {
                          appRoutes.pushNamed(PagesName.findCourseByInterestPage);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0xff6519BA),
                                  child: Icon(
                                    Icons.bolt_rounded,
                                    color: AppColor.white,
                                  )),
                              10.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Find Course by interest",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Find out how to code, design and lots more",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              10.width,
                              Icon(Icons.navigate_next_rounded)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                16.height,

                //Prepare For An Exam Page
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColor.softBorderColor),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          appRoutes.pushNamed(PagesName.prepareForAnExamPage);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0xff6519BA),
                                  child: Icon(
                                    Icons.design_services_rounded,
                                    color: AppColor.white,
                                  )),
                              10.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Prepare for an Exam",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Find popular exam questions and more",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              10.width,
                              Icon(Icons.navigate_next_rounded)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                (controller.tips!.isNotEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.height,
                          Text(
                            "Tips",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          10.height,
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.tips!.length,
                            itemBuilder: (context, index) {
                              final item = controller.tips![index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColor.softBorderColor),
                                ),
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
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => 6.height,
                          )
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
