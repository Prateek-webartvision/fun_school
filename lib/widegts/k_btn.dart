// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../style/assets.dart';

enum BtnType { normal, google, facebook, apple }

class KBtn extends StatelessWidget {
  final Function() onClick;
  final String text;
  final Color? bgColor, fbColor;
  final double? borderRadius, width, height;
  final BtnType? btnType;
  final BorderSide? borderSide;

  const KBtn({
    super.key,
    required this.onClick,
    required this.text,
    this.bgColor,
    this.fbColor,
    this.borderRadius,
    this.width,
    this.height,
    this.btnType = BtnType.normal,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ButtonStyle btnStyle = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(bgColor ?? theme.colorScheme.primary),
      foregroundColor: MaterialStatePropertyAll(fbColor ?? theme.colorScheme.onPrimary),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          side: borderSide ?? BorderSide.none,
        ),
      ),
      fixedSize: MaterialStatePropertyAll(Size(width ?? double.nan, height ?? double.nan)),
    );

    switch (btnType) {
      case BtnType.normal:
        return _normalBtn(btnStyle);
      case BtnType.google:
        return ElevatedButton.icon(
          onPressed: onClick,
          style: btnStyle,
          icon: SvgPicture.asset(AppAssets.svg.googleIcon, height: 24, width: 24),
          label: Text(text),
        );
      case BtnType.facebook:
        return ElevatedButton.icon(
          onPressed: onClick,
          style: btnStyle,
          icon: SvgPicture.asset(
            AppAssets.svg.facebookIcon,
            height: 24,
            width: 24,
            // ignore: deprecated_member_use
            color: AppColor.white,
          ),
          label: Text(text),
        );
      case BtnType.apple:
        return ElevatedButton.icon(
          onPressed: onClick,
          style: btnStyle,
          icon: SvgPicture.asset(AppAssets.svg.appleIcon, height: 24, width: 24),
          label: Text(text),
        );
      default:
        return _normalBtn(btnStyle);
    }
  }

  Widget _normalBtn(ButtonStyle btnStyle) {
    return ElevatedButton(
      style: btnStyle,
      onPressed: onClick,
      child: Text(text),
    );
  }
}

// Cerate plan btn

class CreateStudyPlanBtn extends StatelessWidget {
  const CreateStudyPlanBtn({
    super.key,
    this.text,
    required this.onTap,
  });
  final String? text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text ?? "Create Study Plan",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            6.width,
            Icon(
              Icons.navigate_next_rounded,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
