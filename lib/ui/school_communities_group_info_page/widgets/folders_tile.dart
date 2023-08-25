// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/assets.dart';
import '../../../style/color.dart';
import '../../../style/theme.dart';

class FolderCardTile extends StatelessWidget {
  const FolderCardTile({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppShadow.mainShadow,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.svg.openedFilderIcon),
          12.width,
          Expanded(
              child: Text(
            name,
            style: TextStyle(fontSize: 15),
          )),
          12.width,
          Icon(
            Icons.more_horiz_rounded,
            color: Colors.black45,
          )
        ],
      ),
    );
  }
}
