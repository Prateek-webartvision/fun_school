// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../style/color.dart';

class AnswerSelectorTile extends StatelessWidget {
  const AnswerSelectorTile({
    super.key,
    this.seletedAns,
    required this.options,
    required this.onClick,
  });

  final String? seletedAns;
  final String options;
  final Function(String? v) onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(options),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: (seletedAns == options) ? Border.all(color: AppColor.pinkColor) : null,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.only(right: 16, top: 4, bottom: 4),
        child: Row(
          children: [
            Radio<String?>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: AppColor.pinkColor,
              value: options,
              groupValue: seletedAns,
              onChanged: onClick,
            ),
            Expanded(
              child: Text(
                options,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
