// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/repo/study_plan_repo/study_plan_repo.dart';
import 'package:citycloud_school/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../uitls/app_utils.dart';

class MyStudyPlanSheet extends StatelessWidget {
  const MyStudyPlanSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 48,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColor.scaffoldBg,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                      onTap: () {
                        AppUtils.closeBottomSheet();
                      },
                      child: SizedBox(height: 48, child: Icon(Icons.close))),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Select Study Plan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: StudyPlanRepository.getStudyPlans(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Center(
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        rootNavigator.currentState!.pop(snapshot.data![index].title ?? "");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(border: Border.all(color: AppColor.softBorderColor), borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          snapshot.data![index].title ?? "N/A",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 10.height,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
