// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/widegts/k_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../router/app_router.dart';
import '../../router/pages.dart';
import 'find_course_by_career_state.dart';
import 'widgets/subject_card.dart';
import 'widgets/teg_selector.dart';

class FindCourseByCareerView extends StatefulWidget {
  const FindCourseByCareerView({super.key});
  @override
  State<FindCourseByCareerView> createState() => _FindCourseByCareerViewState();
}

class _FindCourseByCareerViewState extends FindCouresByCareerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text(
          "Courses by Career",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: findCourseByCareerController,
        builder: (controller) {
          if (controller.apiState == ApiState.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.apiState == ApiState.error) {
            return Center(
              child: Text(controller.error.toString()),
            );
          } else {
            // on success
            return SingleChildScrollView(
              child: Column(
                children: [
                  //head
                  Container(
                    // height: 126,
                    decoration: BoxDecoration(color: AppColor.white),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // career
                        SelectCareerDropDown(
                          init: controller.currentCareerTagIndex!,
                          tagSet: controller.careerSet,
                          onSelect: (int index) {
                            controller.changeCareerTag(index);
                          },
                        ),
                        12.height,
                        //
                        KSearchField(onSubmmit: searchSubmmit),
                        12.height,
                        // career tags
                        TagSelector(
                          currentIndex: controller.currentProficiencyTagIndex,
                          tagSet: controller.proficiencySet,
                          onChanged: (index) {
                            controller.changeProficiencyTag(index);
                          },
                        ),
                      ],
                    ),
                  ),

                  10.height,
                  //list

                  (controller.filterList.isEmpty)
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "No courses to show try later, try to change career, seach keyword",
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Column(
                          children: [
                            CarouselSlider.builder(
                              itemCount: controller.filterList.length,
                              itemBuilder: (context, index, realIndex) {
                                final item = controller.filterList[index];
                                return GestureDetector(
                                  onTap: () {
                                    appRoutes.pushNamed(
                                      PagesName.subjectDetailsPage,
                                      extra: item,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        SubjectCard(
                                          name: "${item.courseName}",
                                          icon: Icons.book,
                                        ),
                                        Container(
                                          width: double.maxFinite,
                                          height: 350,
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            border: Border.all(color: AppColor.softBorderColor),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                // color: Colors.green,
                                                width: double.maxFinite,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    item.courseDescription!,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //image
                                              Image(
                                                width: double.maxFinite,
                                                height: 250,
                                                image: NetworkImage(item.courseCoverImage!),
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                initialPage: 0,
                                aspectRatio: 1,
                                viewportFraction: 1,
                                height: 350 + 93,
                                enableInfiniteScroll: false,
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  smoothIndicatorController.changeIndex(index);
                                },
                              ),
                            ),
                            8.height,
                            //
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
                                    count: controller.filterList.length,
                                  ),
                                );
                              },
                            )
                            // Expanded(
                            //   child: ListView(
                            //     padding: EdgeInsets.all(16),
                            //     children: [
                            //       SelectIntreset(
                            //         initInterest: controller.seletedInterest,
                            //         interestList: controller.interestSet.toList(),
                            //         onItemClick: (interest) {
                            //           controller.changeInterestTag(interest);
                            //         },
                            //       ),
                            //       12.height,
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Flexible(
                            //             // fit: FlexFit.loose,
                            //             flex: 2,
                            //             child: Text(
                            //               "School Level",
                            //               style: TextStyle(
                            //                 fontSize: 14,
                            //                 fontWeight: FontWeight.w600,
                            //               ),
                            //             ),
                            //           ),
                            //           Flexible(
                            //             flex: 3,
                            //             fit: FlexFit.tight,
                            //             child: SchoolDropdown(
                            //               selectedScholl: controller.schoolLevel,
                            //               controller: SchoolSelectorController(schoolSeletedIndex: 0),
                            //               onItemClick: (lavel) {
                            //                 controller.changeSchoolLavel(lavel);
                            //               },
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       12.height,
                            //       (controller.filterList.isEmpty)
                            //           ? Column(
                            //               children: [
                            //                 40.height,
                            //                 Center(
                            //                   child: Text("No Data found or Change filters"),
                            //                 ),
                            //               ],
                            //             )
                            //           : ListView.separated(
                            //               shrinkWrap: true,
                            //               physics: NeverScrollableScrollPhysics(),
                            //               itemCount: controller.filterList.length,
                            //               itemBuilder: (context, index) {
                            //                 return SubjectCard(
                            //                   name: "${controller.filterList[index].courseName}",
                            //                   icon: Icons.book,
                            //                   onTap: () {
                            //                     // appRoutes.pushNamed(PagesName.coursesBySchoolDetailsPage);
                            //                     appRoutes.pushNamed(
                            //                       PagesName.subjectDetailsPage,
                            //                       extra: controller.filterList[index],
                            //                     );
                            //                   },
                            //                   // iconBg: Color(0xffEF6F38),
                            //                 );
                            //               },
                            //               separatorBuilder: (context, index) => 8.height,
                            //             ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class SelectCareerDropDown extends StatelessWidget {
  const SelectCareerDropDown({
    super.key,
    this.init = 0,
    required this.onSelect,
    required this.tagSet,
  });
  final Set<String> tagSet;
  final int init;
  final Function(int index) onSelect;

  @override
  Widget build(BuildContext context) {
    // print(schoolSelectorController.schools);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Career",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        4.height,
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColor.softBorderColor),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          child: DropdownButton(
            value: tagSet.elementAt(init),
            // hint: Text("Select Interest", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            style: TextStyle(
              fontSize: 14,
              // fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(4),
            alignment: Alignment.centerLeft,
            dropdownColor: AppColor.white,
            underline: SizedBox(),
            isDense: true,

            onChanged: (value) => onSelect(tagSet.toList().indexOf(value!)),

            items: tagSet.map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text((value.isNotEmpty) ? value.capitalize! : "N/A"),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
