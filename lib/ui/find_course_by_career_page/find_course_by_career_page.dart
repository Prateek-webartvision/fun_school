import 'package:citycloud_school/router/app_router.dart';
import 'package:citycloud_school/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FindCourseByCareer extends StatelessWidget {
  const FindCourseByCareer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            appRoutes.pushNamed(PagesName.courseByCareerDetailsPage);
          },
          child: Text("${GoRouterState.of(context).fullPath}"),
        ),
      ),
    );
  }
}
