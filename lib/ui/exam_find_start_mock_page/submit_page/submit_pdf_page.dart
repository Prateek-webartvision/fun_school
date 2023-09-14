// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/const.dart';

class MockSubmitPdfPage extends StatefulWidget {
  const MockSubmitPdfPage({super.key});

  @override
  State<MockSubmitPdfPage> createState() => _MockSubmitPdfPageState();
}

class _MockSubmitPdfPageState extends State<MockSubmitPdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        title: Text("Exam Preparation"),
        centerTitle: true,
        bottom: PreferredSize(preferredSize: Size.fromHeight(0), child: Divider(height: 0)),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.scaffoldBg,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        "Question 1",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    //
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.scaffoldBg,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        "100 point",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                12.height,
                //
                Text(
                  "Write Essay About Artifial Intelegence",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                12.height,
                Container(
                  height: 193,
                  decoration: BoxDecoration(
                    color: AppColor.scaffoldBg,
                    image: DecorationImage(
                      image: AssetImage(AppAssets.startExamTextBg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          14.height,
          //
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(color: AppColor.softBorderColor),
              borderRadius: BorderRadius.circular(4),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(color: AppColor.mainColor, borderRadius: BorderRadius.circular(30)),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(AppAssets.svg.uploadIcon),
                ),
                10.height,
                Text(
                  "Upload Answers PDF",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          12.height, // attech file name
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.svg.attachment2Icon),
                      4.width,
                      Text(
                        "Essay-ahamd.pdf",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColor.mainColor,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.close, size: 20),
                ],
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: KBtn(
                bgColor: AppColor.white,
                fbColor: Colors.black,
                borderSide: BorderSide(color: AppColor.softBorderColor),
                onClick: () {},
                text: "Let’s Go",
                height: 44,
              ),
            ),
            12.width,
            Expanded(
              child: KBtn(
                height: 44,
                onClick: () {},
                text: "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
