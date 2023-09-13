// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../style/theme.dart';

class ExamSubjectTile extends StatelessWidget {
  const ExamSubjectTile({
    super.key,
    required this.title,
    required this.editions,
    this.onClick,
  });
  final String title;
  final int editions;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: AppShadow.boxShadow,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              "$editions Edtition",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
