// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../style/const.dart';

// ignore: must_be_immutable
class PlanStudyScheduleTile extends StatelessWidget {
  // static PlanStudyScheduleTile _planStudyScheduleTile;

  PlanStudyScheduleTile._({
    required this.title,
    required this.subTitle,
    this.onEdit,
  });

  factory PlanStudyScheduleTile.edit({required String title, required String subTitle, Function()? onEdit}) {
    return PlanStudyScheduleTile._(
      title: title,
      subTitle: subTitle,
      onEdit: onEdit,
    );
  }

  factory PlanStudyScheduleTile({
    required String title,
    required String subTitle,
  }) {
    return PlanStudyScheduleTile._(title: title, subTitle: subTitle);
  }

  final String title;
  final String subTitle;
  Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.scaffoldBg,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.text12W400,
          ),
          Row(
            children: [
              Text(
                subTitle,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              if (onEdit != null) 6.width,
              if (onEdit != null) Icon(Icons.edit, size: 16),
            ],
          )
        ],
      ),
    );
  }
}
