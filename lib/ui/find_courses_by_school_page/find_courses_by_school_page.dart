import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';

class FindCoursesBySchool extends StatelessWidget {
  const FindCoursesBySchool({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses by School "),
        shadowColor: Colors.black,
        elevation: 1,
        backgroundColor: AppColor.scaffoldBg,
      ),
    );
  }
}
