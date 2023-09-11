import 'package:flutter/material.dart';

import '../../../style/color.dart';

class AssessmentTile extends StatelessWidget {
  const AssessmentTile({
    super.key,
    required this.title,
    required this.score,
    required this.sipStatus,
  });
  final String title;
  final int score;
  final String sipStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Score: $score%",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.mainColor,
                ),
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              text: "SIP Status: ",
              children: [
                TextSpan(text: sipStatus, style: const TextStyle(color: AppColor.yellow)),
              ],
            ),
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
