import 'package:fun_school/style/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class ExamTile extends StatelessWidget {
  const ExamTile({
    super.key,
    this.color,
    required this.title,
    this.onClick,
    required this.date,
  });
  final Color? color;
  final String title;
  final Function()? onClick;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              // child: const Icon(Icons.edit_document, color: AppColor.white),
              child: SvgPicture.asset(AppAssets.svg.bookEdit),
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
                    "Latest Year: ${date.year}",
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
