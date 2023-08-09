import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:kd_utils/kd_utils.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error, required this.onError});
  final String error;
  final Function() onError;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(),
        Text(error),
        10.height,
        GestureDetector(
          onTap: onError,
          child: Icon(
            Icons.replay,
            size: 40,
            color: context.theme.primaryColor,
          ),
        ),
      ],
    );
  }
}
