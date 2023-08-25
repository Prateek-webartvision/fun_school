// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../style/assets.dart';
import '../../../style/color.dart';
import '../../../style/theme.dart';

class FileTile extends StatelessWidget {
  const FileTile({
    super.key,
    required this.svgIcon,
  });
  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppShadow.mainShadow,
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Align(alignment: Alignment.center, child: SvgPicture.asset(svgIcon)),
                Positioned(
                  right: 16,
                  top: 16,
                  child: Icon(
                    Icons.more_horiz_rounded,
                    color: Colors.black45,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 54,
            width: double.maxFinite,
            alignment: Alignment.center,
            child: Text(
              "StudyFile.${(svgIcon == AppAssets.svg.zipIcon) ? "zip" : "jpg"}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
