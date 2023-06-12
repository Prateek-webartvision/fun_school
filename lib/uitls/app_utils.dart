import 'package:flutter/material.dart';

import '../router/app_router.dart';

class AppUtils {
  static showModelSheet({
    required Widget child,
    required bool isScrolled,
    ShapeBorder? shape,
    Color? bgColor,
    Clip? clip,
  }) {
    rootNavigator.currentState!.push(ModalBottomSheetRoute(
      builder: (context) => child,
      isScrollControlled: isScrolled,
      shape: shape,
      backgroundColor: bgColor,
      clipBehavior: clip ?? Clip.hardEdge,
    ));
  }
}
