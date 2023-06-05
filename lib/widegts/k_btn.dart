import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../style/assets.dart';

enum BtnType { normal, google, facebook, apple }

class KBtn extends StatelessWidget {
  final Function() onClick;
  final String text;
  final Color? bgColor, fbColor;
  final double? borderRadius, width, height;
  final BtnType? btnType;
  // final Tex

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
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ButtonStyle btnStyle = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(bgColor ?? theme.colorScheme.primary),
      foregroundColor: MaterialStatePropertyAll(fbColor ?? theme.colorScheme.onPrimary),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 4))),
      fixedSize: MaterialStatePropertyAll(Size(width ?? double.nan, height ?? double.nan)),
    );

    switch (btnType) {
      case BtnType.normal:
        return ElevatedButton(
          style: btnStyle,
          onPressed: onClick,
          child: Text(text),
        );
      case BtnType.google:
        return ElevatedButton.icon(
          onPressed: onClick,
          style: btnStyle,
          icon: SvgPicture.asset(AppAssets.googleIcon, height: 24, width: 24),
          label: Text(text),
        );
      case BtnType.facebook:
        return ElevatedButton.icon(
          onPressed: onClick,
          style: btnStyle,
          icon: SvgPicture.asset(
            AppAssets.facebookIcon,
            height: 24,
            width: 24,
            color: AppColor.white,
          ),
          label: Text(text),
        );
      case BtnType.apple:
        return ElevatedButton.icon(
          onPressed: onClick,
          style: btnStyle,
          icon: SvgPicture.asset(AppAssets.appleIcon, height: 24, width: 24),
          label: Text(text),
        );
      default:
        return ElevatedButton(
          style: btnStyle,
          onPressed: onClick,
          child: Text(text),
        );
    }
  }
}
