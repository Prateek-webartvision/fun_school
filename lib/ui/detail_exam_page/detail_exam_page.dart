// ignore_for_file: prefer_const_constructors

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
        ],
      ),
    );
  }
}
