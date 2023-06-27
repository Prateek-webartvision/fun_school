// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../uitls/app_utils.dart';

class MoreMenuSheet extends StatelessWidget {
  const MoreMenuSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      // height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 48,
            width: double.maxFinite,
            decoration: BoxDecoration(color: AppColor.scaffoldBg),
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
                    "Quick Access",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // option row 1
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppUtils.closeBottomSheet();
                    AppUtils.showSnack("Coming soon");
                  },
                  child: SizedBox(
                    width: 114,
                    height: 70,
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.summarize,
                          size: 24,
                        ),
                        4.height,
                        Text(
                          "Power Summary",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppUtils.closeBottomSheet();
                    AppUtils.showSnack("Coming soon");
                  },
                  child: SizedBox(
                    width: 114,
                    height: 70,
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          size: 24,
                        ),
                        4.height,
                        Text(
                          "Community",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppUtils.closeBottomSheet();
                    AppUtils.showSnack("Coming soon");
                  },
                  child: SizedBox(
                    width: 114,
                    height: 70,
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.question_mark_rounded,
                          size: 24,
                        ),
                        4.height,
                        Text(
                          "Ask a question",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // option row 2
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppUtils.closeBottomSheet();
                    AppUtils.showSnack("Coming soon");
                  },
                  child: SizedBox(
                    width: 114,
                    height: 70,
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_box_outlined,
                          size: 24,
                        ),
                        4.height,
                        Text(
                          "Topic",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    rootNavigator.currentState!.pop("note");
                  },
                  child: SizedBox(
                    width: 114,
                    height: 70,
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_add_sharp,
                          size: 24,
                        ),
                        4.height,
                        Text(
                          "Notes",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppUtils.closeBottomSheet();
                    AppUtils.showSnack("Coming soon");
                  },
                  child: SizedBox(
                    width: 114,
                    height: 70,
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.screen_share_outlined,
                          size: 24,
                        ),
                        4.height,
                        Text(
                          "Share",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
