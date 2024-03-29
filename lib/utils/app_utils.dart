// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/courses_details/courses.model.dart';
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
    if (scaffoldManagerKey.currentState != null) {
      scaffoldManagerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  //* loading overlay
  static Future<void> showLoadingOverlay(Future Function() futureFun) async {
    final OverlayEntry entry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black26,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              padding: EdgeInsets.all(4),
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
    rootNavigator.currentState!.overlay!.insert(entry);

    await futureFun();
    entry.remove();
  }

  static bool isCourseEnrolledByMe({required List<CoursesEnrollment> enrolls}) {
    var isEnrolled = enrolls.where((element) =>
        int.parse(element.userId!) == AppStorage.user.currentUser()!.userId!);
    if (isEnrolled.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static slidePush({required Widget page}) {
    rootNavigator.currentState!.push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
          final slide = SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: page,
          );

          return slide;
        },
      ),
    );
  }

  // get readable duration
  static String getReadableDuration(Duration duration) {
    // final Duration dd = Duration(hours: 09, minutes: 10);
    int hur = (duration.inHours % 60);
    int min = (duration.inMinutes % 60);

    final time =
        "${(hur >= 1) ? "$hur hours" : ""} ${(min >= 1) ? "$min minutes" : ""}";
    return time;
  }
}

class MyDialog<T> extends RawDialogRoute<T> {
  MyDialog()
      : super(
          pageBuilder: (BuildContext context, Animation<double> anim,
              Animation<double> anim2) {
            Tween<Offset> tw =
                Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
            final animation =
                CurvedAnimation(curve: Curves.easeIn, parent: anim);
            final slid = SlideTransition(
              position: tw.animate(animation),
              child: Center(child: Material(child: Text("data"))),
            );
            return slid;
          },
          barrierDismissible: true,
        );
}
