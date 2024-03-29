// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fun_school/repo/subject_notes_repo/notes_repo.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/widgets/k_btn.dart';
import 'package:fun_school/widgets/k_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../utils/app_utils.dart';

class TakeNoteSheet extends StatefulWidget {
  const TakeNoteSheet({
    super.key,
    required this.subjectId,
    required this.noteTitle,
    required this.contentTitle,
    required this.subTitle,
    required this.courseId,
  });
  final String courseId;
  final int subjectId;
  final String noteTitle;
  final String contentTitle;
  final String subTitle;

  @override
  State<TakeNoteSheet> createState() => _TakeNoteSheetState();
}

class _TakeNoteSheetState extends State<TakeNoteSheet> {
  final TextEditingController noteText = TextEditingController();

  @override
  void dispose() {
    noteText.dispose();
    super.dispose();
  }

  onCancelClick() {
    rootNavigator.currentState!.pop();
  }

  onAddNoteClick() {
    if (noteText.text.isEmpty) {
      AppUtils.showSnack("Enter Note Text");
    } else {
      AppUtils.showLoadingOverlay(() async {
        rootNavigator.currentState!.focusNode.unfocus();
        var res = await NotesRepository.addNote(
          courseId: widget.courseId,
          subjectId: widget.subjectId,
          subtitle: widget.subTitle,
          contentTitle: widget.contentTitle,
          note: noteText.text.trim(),
        );
        if (res != null) {
          rootNavigator.currentState!.pop();
          AppUtils.showSnack(res);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  "Notes",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // note take
        Container(
          height: 141,
          width: double.maxFinite,
          padding: EdgeInsets.all(16),
          child: KTextField(
            hint: "Notes",
            controller: noteText,
            maxLine: 3,
          ),
        ),

        // btns
        SizedBox(
          height: 56,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KBtn(
                height: 44,
                width: 165,
                onClick: onCancelClick,
                text: "Cancel",
                bgColor: AppColor.white,
                borderSide: BorderSide(color: AppColor.softBorderColor),
                fbColor: Colors.black,
                borderRadius: 4,
              ),
              12.width,
              KBtn(
                width: 165,
                height: 44,
                onClick: onAddNoteClick,
                text: "Add Note",
                borderRadius: 4,
              ),
            ],
          ),
        )
      ],
    );
  }
}
