import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';

class SubjectDetailsPage extends StatelessWidget {
  const SubjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          )
        ],
      ),
    );
  }
}
