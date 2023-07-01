// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class AnsOptions extends StatelessWidget {
  const AnsOptions({
    super.key,
    required this.options,
    required this.onItemClick,
    this.seletedAns,
  });
  final List<String> options;
  final Function(String ans) onItemClick;
  final String? seletedAns;

  @override
  Widget build(BuildContext context) {
    int char = "a".codeUnitAt(0);
    return ListView.separated(
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onItemClick(options[index]),
          child: Container(
            constraints: BoxConstraints(minHeight: 60),
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(color: (seletedAns == options[index]) ? AppColor.pinkColor : AppColor.softBorderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                text: "${String.fromCharCode(char + index).capitalize}.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: " "),
                  TextSpan(
                    text: options[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // child: Text("${String.fromCharCode(char + index).capitalize}. ${options[index]}"),
          ),
        );
      },
      separatorBuilder: (context, index) => 8.height,
    );
  }
}
