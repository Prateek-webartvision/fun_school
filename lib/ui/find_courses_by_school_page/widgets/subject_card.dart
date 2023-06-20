// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class SubjectCard extends StatefulWidget {
  const SubjectCard({
    super.key,
    required this.name,
    required this.icon,
    // this.selected = false,
    this.onTap,
  });
  final String name;
  final IconData icon;

  final Function()? onTap;

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.softBorderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColor.mainColor,
              child: Icon(
                widget.icon,
                color: AppColor.white,
              ),
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "14 hours . Downloadable",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  4.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.play_circle_fill_rounded,
                        color: Color(0xff6938EF),
                        size: 18,
                      ),
                      6.width,
                      Text(
                        "Videos",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      13.width,
                      Icon(
                        Icons.info_rounded,
                        color: Color(0xff6938EF),
                        size: 18,
                      ),
                      6.width,
                      Text(
                        "Quizzes",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            10.width,
            Checkbox(
              value: selected,
              fillColor: MaterialStatePropertyAll(AppColor.pinkColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              side: BorderSide(
                color: AppColor.softBorderColor,
                width: 1,
              ),
              onChanged: (value) {
                setState(() {
                  selected = value!;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
