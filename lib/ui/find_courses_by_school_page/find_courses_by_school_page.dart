// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';
import '../../widegts/k_text_field.dart';
import 'controller/find_courses_by_school_controller.dart';
import 'widgets/collage_card.dart';
import 'widgets/subject_card.dart';

class FindCoursesBySchoolPage extends StatefulWidget {
  const FindCoursesBySchoolPage({super.key});

  @override
  State<FindCoursesBySchoolPage> createState() => _FindCoursesBySchoolPageState();
}

class _FindCoursesBySchoolPageState extends State<FindCoursesBySchoolPage> {
  FindCoursesBySchoolController findCoursesBySchoolController = FindCoursesBySchoolController();

  @override
  void initState() {
    // Get.lazyPut(() => FindCoursesBySchoolController()..getCourses());
    // findCoursesBySchoolController = Get.find<FindCoursesBySchoolController>();
    findCoursesBySchoolController.getCourses();
    super.initState();
  }

  @override
  void dispose() {
    findCoursesBySchoolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses by School", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: AppColor.scaffoldBg,
      ),
      //
      body: GetBuilder(
        init: findCoursesBySchoolController,
        builder: (controller) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    height: 114,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border(
                        top: BorderSide(color: AppColor.softBorderColor),
                        bottom: BorderSide(color: AppColor.softBorderColor),
                      ),
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      children: [
                        CollageCard(
                          name: "Junior secondary school",
                          icon: Icons.account_balance_sharp,
                          onSelect: (v) {
                            print(v);
                          },
                        ),
                        10.width,
                        CollageCard(
                          name: "Senior secondary school",
                          icon: Icons.business_outlined,
                          isSelected: true,
                        ),
                        10.width,
                        CollageCard(
                          name: "University",
                          icon: Icons.temple_buddhist_outlined,
                        ),
                      ],
                    ),
                  ),
                ),

                // stiky search bar
                SliverPadding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  sliver: SliverPersistentHeader(
                    // pinned: true,
                    delegate: MyHeaderDelegate(
                      child: KSearchField(),
                    ),
                  ),
                ),
              ];
            },
            body: (controller.apiState == ApiState.loading)
                ? Center(child: CircularProgressIndicator())
                : (controller.apiState == ApiState.error)
                    ? Center(
                        child: Text(controller.error.toString()),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.all(16),
                        itemCount: controller.coursesList!.length,
                        itemBuilder: (context, index) {
                          return SubjectCard(
                            // name: "Mathematics",
                            name: controller.coursesList![index].courseName!,
                            icon: Icons.group,
                            // selected: true,
                            onTap: () {
                              appRoutes.pushNamed(PagesName.coursesBySchoolDetailsPage);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => 8.height,
                        // children: [
                        //   SubjectCard(
                        //     name: "Mathematics",
                        //     icon: Icons.group,
                        //     selected: true,
                        //     onTap: () {
                        //       appRoutes.pushNamed(PagesName.coursesBySchoolDetailsPage);
                        //     },
                        //   ),
                        //   8.height,
                        //   SubjectCard(name: "English", icon: Icons.group, selected: false),
                        //   8.height,
                        //   SubjectCard(name: "Physics", icon: Icons.group, selected: false),
                        //   8.height,
                        //   SubjectCard(name: "Chemistry", icon: Icons.group, selected: false),
                        //   8.height,
                        //   SubjectCard(name: "Biology", icon: Icons.group, selected: false),
                        //   8.height,
                        //   SubjectCard(name: "Economics", icon: Icons.group, selected: false),
                        // ],
                      ),
          );
        },
      ),
      floatingActionButton: KBtn(
        onClick: () async {},
        text: "Add to Study Plan",
        width: MediaQuery.of(context).size.width - 32,
        height: 44,
        bgColor: Color(0xff6938EF),
      ),
    );
  }
}

//
class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  MyHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
