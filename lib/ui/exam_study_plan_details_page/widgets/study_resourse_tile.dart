// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../style/color.dart';
import '../../../style/const.dart';

class StudyResourseTile extends StatelessWidget {
  const StudyResourseTile({
    super.key,
    required this.title,
    required this.url,
  });
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.scaffoldBg,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.text12W400,
              ),
              Icon(Icons.edit, size: 16, color: AppColor.mainColor),
            ],
          ),
          Text(
            url,
            // "www.mathstudy.com/algebra-notes das da sd asd as d asd a sd ",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
