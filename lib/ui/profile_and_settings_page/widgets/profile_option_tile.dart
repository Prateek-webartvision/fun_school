import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class ProfileOptionTile extends StatelessWidget {
  const ProfileOptionTile({
    super.key,
    required this.title,
    this.tralingText,
    this.leadingIcon,
    this.color,
    this.onClick,
  });

  final String title;
  final String? tralingText;
  final IconData? leadingIcon;
  final Color? color;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 44,
        decoration: const BoxDecoration(color: AppColor.white),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            (leadingIcon != null)
                ? Icon(
                    // Icons.email,
                    leadingIcon,
                    color: color ?? context.theme.primaryColor,
                    size: 18,
                  )
                : 0.width,
            (leadingIcon != null) ? 6.width : 0.width,
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
            (tralingText != null) ? 10.width : 0.width,
            (tralingText != null)
                ? Expanded(
                    child: Text(
                      tralingText!,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.end,
                    ),
                  )
                : 0.width,
            6.width,
            const Icon(
              Icons.navigate_next_rounded,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
