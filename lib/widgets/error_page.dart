// ignore_for_file: prefer_const_constructors

import 'package:fun_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage(
      {super.key, required this.error, required this.onError, this.textColor});
  final String error;
  final Function() onError;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment(0, -0.3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/error.png",
                height: 240,
              ),
              60.height,
              Text("Oops...",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor)),
              3.height,
              Text(error,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: textColor)),
              30.height,
              GestureDetector(
                  onTap: onError,
                  child: Container(
                    height: 44,
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text("Try again",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
