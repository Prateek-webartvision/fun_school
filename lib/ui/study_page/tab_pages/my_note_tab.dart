// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/ui/study_page/controller/my_notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../widgets/note_dailog.dart';

class MyNoteTab extends StatelessWidget {
  const MyNoteTab({
    super.key,
    required this.myNotesController,
  });
  final MyNotesController myNotesController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: myNotesController,
      builder: (controller) {
        if (controller.apiState == ApiState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.apiState == ApiState.error) {
          return Center(child: Text(controller.error.toString()));
        } else {
          return ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: controller.myNotes!.length,
            itemBuilder: (context, index) {
              return NoteTile(
                title: (controller.myNotes![index].first.courseName!.isNotEmpty) ? controller.myNotes![index].first.courseName! : "N/A",
                notes: controller.myNotes![index],
              );
            },
            separatorBuilder: (context, index) => 10.height,
          );
        }
      },
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.title,
    required this.notes,
  });
  final String title;
  final List<NotesModel> notes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.softBorderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Container(
            // color: Colors.green,
            height: 44,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // add Title
                    Text(
                      // "Alegbra Foundations",
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // notes count
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.scaffoldBg,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColor.textFeildBorderColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "${notes.length} Notes",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          // notes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.separated(
              itemCount: notes.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // "Overview and history algebra",
                      notes[index].subtitle!,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    4.height,
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return NoteDailog(noteData: notes[index]);
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border.all(color: AppColor.softBorderColor),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.note_rounded,
                              color: context.appTheme.colorScheme.primary,
                            ),
                            12.width,
                            Expanded(
                              child: Text(
                                // "“Sample Note”",
                                notes[index].notes!,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            12.width,
                            Icon(Icons.copy_rounded),
                            12.width,
                            Icon(Icons.notes_rounded)
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) => 12.height,
            ),
          ),
          12.height,
        ],
      ),
    );
  }
}
