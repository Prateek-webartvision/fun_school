// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../uitls/helper.dart';
import '../controller/week_day_selector_controller.dart';

class WeekDaySelector extends StatelessWidget {
  const WeekDaySelector({
    super.key,
    required this.weekDays,
    required this.controller,
  });

  final List<int> weekDays;
  final WeekDaySelectorController controller;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (cnt) {
        return Row(
          children: weekDays
              .asMap()
              .map((i, e) {
                return MapEntry(
                  i,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (cnt.currentIndex != i) {
                            cnt.currentIndex = i;
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 9.9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: (cnt.currentIndex == i) ? AppColor.mainColor : AppColor.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              getWeekDay(e, inSort: true).toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: (cnt.currentIndex == i) ? AppColor.white : Colors.black,
                              ),
                            )),
                      ),
                      if (i >= weekDays.length - 1) 0.width else 5.width,
                    ],
                  ),
                );
              })
              .values
              .toList(),
        );
      },
    );
  }
}
