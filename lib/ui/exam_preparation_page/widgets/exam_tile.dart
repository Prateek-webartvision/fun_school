import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class ExamTile extends StatelessWidget {
  const ExamTile({
    super.key,
    this.color,
    required this.title,
    this.onClick,
  });
  final Color? color;
  final String title;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   AppUtils.showSnack("coming soon");
      // },
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.softBorderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color,
              child: const Icon(Icons.edit_document, color: AppColor.white),
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Users : 35,400 - Latest Year: 2023",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            10.width,
            const Icon(
              Icons.navigate_next_rounded,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
