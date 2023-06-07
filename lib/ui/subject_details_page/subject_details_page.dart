// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import 'tab_pages/algebra_tab.dart';

class SubjectDetailsPage extends StatefulWidget {
  const SubjectDetailsPage({super.key});

  @override
  State<SubjectDetailsPage> createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> with TickerProviderStateMixin {
  late TabController pageTabController;

  @override
  void initState() {
    pageTabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    pageTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          // Text()
          _HeadTitle(controller: pageTabController),

          //body
          Expanded(
            child: TabBarView(
              controller: pageTabController,
              children: [
                AlgebraTab(),
                AlgebraTab(),
                AlgebraTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeadTitle extends StatelessWidget {
  const _HeadTitle({required this.controller});
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // subject head title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "14 hours . Downloadable",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Mathematics",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  4.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.play_circle_fill_rounded,
                        color: Color(0xff6938EF),
                        size: 18,
                      ),
                      6.width,
                      Text(
                        "Videos",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      13.width,
                      Icon(
                        Icons.info_rounded,
                        color: Color(0xff6938EF),
                        size: 18,
                      ),
                      6.width,
                      Text(
                        "Quizzes",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              // subject add btn
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(48),
                  border: Border.all(color: AppColor.softBorderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0F101828),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                    BoxShadow(
                      color: Color(0x1A101828),
                      offset: Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.add_rounded,
                  color: AppColor.mainColor,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        // tab bar
        Container(
          height: 28,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: TabBar(
            controller: controller,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            splashFactory: NoSplash.splashFactory,
            dividerColor: Colors.transparent,
            unselectedLabelColor: AppColor.unSelectedTapColor,
            tabs: [
              Tab(text: "Algebra"),
              Tab(text: "Ratios"),
              Tab(text: "Trigonometry"),
            ],
          ),
        ),
      ],
    );
  }
}
