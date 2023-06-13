// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/color.dart';

class DetailExamPage extends StatefulWidget {
  const DetailExamPage({super.key});

  @override
  State<DetailExamPage> createState() => _DetailExamPageState();
}

class _DetailExamPageState extends State<DetailExamPage> with TickerProviderStateMixin {
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
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                14.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "JAMB",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
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
                14.height,
                SizedBox(
                  height: 28,
                  child: TabBar(
                    labelPadding: EdgeInsets.only(right: 24),
                    controller: pageTabController,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    splashFactory: NoSplash.splashFactory,
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: AppColor.unSelectedTapColor,
                    tabs: const [
                      Tab(text: "Real"),
                      Tab(text: "Past"),
                      Tab(text: "Practice"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //body
          Expanded(
              child: TabBarView(
            controller: pageTabController,
            children: [
              _RealTabView(),
              _RealTabView(),
              _RealTabView(),
            ],
          ))
        ],
      ),
    );
  }
}

class _RealTabView extends StatelessWidget {
  // const _RealTabView({
  //   super.key,
  // });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _ExamTile(
          completeState: 1,
          onClick: () {
            appRoutes.pushNamed(PagesName.startExamPage);
            // print("object ${appRoutes.location}");
          },
        ),
        12.height,
        _ExamTile(completeState: 2),
        12.height,
        _ExamTile(completeState: 3),
      ],
    );
  }
}

class _ExamTile extends StatelessWidget {
  const _ExamTile({
    super.key,
    required this.completeState,
    this.onClick,
  });

  final int completeState;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.softBorderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 24,
                  decoration: BoxDecoration(
                    color: AppColor.scaffoldBg,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.black),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "Question $completeState/7",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.scaffoldBg,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColor.textFeildBorderColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "1 point",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            8.height,
            Text(
              "Of the following, which best describes a variable?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
