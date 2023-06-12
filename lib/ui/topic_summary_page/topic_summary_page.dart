// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:citycloud_school/widegts/k_btn.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

class TopicSummaryPage extends StatelessWidget {
  const TopicSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        title: Text("Topic Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        children: [
          Text("Introduction to variables", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          12.height,
          Container(
            height: 131,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/img/study.jpg"),
              ),
            ),
            padding: EdgeInsets.all(12),
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                AppUtils.showModelSheet(
                  child: _MoreInfoSheet(),
                  isScrolled: true,
                  bgColor: AppColor.scaffoldBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColor.scaffoldBg,
                  border: Border.all(color: AppColor.softBorderColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text("More Information", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          12.height,
          Text(
            """As a single word without an article, "algebra" names a broad part of mathematics.
As a single word with an article or in the plural, "an algebra" or "algebras" denotes a specific mathematical structure, whose precise definition depends on the context. Usually, the structure has an addition, multiplication, and scalar multiplication (see Algebra over a field). When some authors use the term "algebra", they make a subset of the following additional assumptions: associative, commutative, unital, and/or finite-dimensional. In universal algebra, the word "algebra" refers to a generalization of the above concept, which allows for n-ary operations.
With a qualifier, there is the same distinction:
Without an article, it means a part of algebra, such as linear algebra, elementary algebra (the symbol-manipulation rules taught in elementary courses of mathematics as part of primary and secondary education), or abstract algebra (the study of the algebraic structures for themselves).
With an article, it means an instance of some algebraic structure, like a Lie algebra, an associative algebra, or a vertex operator algebra.
Sometimes both meanings exist for the same qualifier, as in the sentence: Commutative algebra is the study of commutative rings, which are commutative algebras over the integers.""",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 76,
        color: AppColor.scaffoldBg,
        padding: EdgeInsets.only(top: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  print("Back");
                },
                child: Column(
                  children: [
                    Icon(Icons.arrow_circle_left_outlined),
                    Text("Overview and history algebra", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  print("next");
                },
                child: Column(
                  children: [
                    Icon(Icons.arrow_circle_right),
                    Text(
                      "Substitution and evaluating expressions",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// bottom sheet
class _MoreInfoSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 48,
          width: double.maxFinite,
          color: Color(0xfff4f4f4),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.close,
                    size: 24,
                  )),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Create Exam",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
          color: AppColor.softBorderColor,
        ),
        16.height,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              Text(
                "Algebra",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Text(
                "Algebra (from Arabic ‏الجبر‎ (al-jabr) 'reunion of broken parts,[1] bonesetting'[2]) is the study of variables and the rules for manipulating these variables in formulas;[3] it is a unifying thread of almost all of mathematics.[4] Elementary algebra deals with the manipulation of variabl",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              16.height,
              KBtn(
                onClick: () {},
                text: "Share",
                width: double.maxFinite,
              ),
              16.height,
            ],
          ),
        )
      ],
    );
  }
}
