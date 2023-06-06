import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../widegts/k_text_field.dart';

class FindAnExamTab extends StatelessWidget {
  const FindAnExamTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const KSearchField(),
        12.height,
        const _Tile(title: "JAMB", color: Color(0xff6519BA)),
        12.height,
        const _Tile(title: "JAMB", color: Color(0xffEF6F38)),
        12.height,
        const _Tile(title: "JAMB", color: Color(0xff3897EF)),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({this.color, required this.title});
  final Color? color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )),
          10.width,
          const Icon(
            Icons.navigate_next_rounded,
            size: 20,
          )
        ],
      ),
    );
  }
}
