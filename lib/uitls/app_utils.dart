// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/courses_dedails/courses.model.dart';
import '../network/data/app_storage.dart';
import '../router/app_router.dart';

class AppUtils {
  // bottom sheet
  static Future showModelSheet({
    required Widget child,
    required bool isScrolled,
    ShapeBorder? shape,
    Color? bgColor,
    Clip? clip,
  }) async {
    return await rootNavigator.currentState!.push(
      ModalBottomSheetRoute(
        builder: (context) => child,
        isScrollControlled: isScrolled,
        elevation: 100,
        shape: shape,
        backgroundColor: bgColor,
        clipBehavior: clip ?? Clip.hardEdge,
      ),
    );
  }

  static closeBottomSheet() {
    rootNavigator.currentState!.pop();
  }

  // snack bar
  static showSnack(String message) {
    if (scaffoldMenagerKey.currentState != null) {
      scaffoldMenagerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // loading overlay
  static showloadingOverlay(Future Function() futureFun) async {
    final OverlayEntry _entry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black26,
          child: Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
              padding: EdgeInsets.all(4),
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    //
    rootNavigator.currentState!.overlay!.insert(_entry);

    await futureFun();
    _entry.remove();
  }

  static bool isCourseEnroledByMe({required List<CoursesEnrollment> enrolls}) {
    // print()
    var isEnrolled = enrolls.where((element) => int.parse(element.userId!) == AppStorage.user.currentUser()!.userid!);
    if (isEnrolled.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
