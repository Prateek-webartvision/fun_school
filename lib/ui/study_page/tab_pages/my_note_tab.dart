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
          if (controller.myNotes!.isEmpty) {
            return Center(child: Text("Notes not found"));
          } else {
            // print(controller.myNotes);
            return ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: controller.myNotes!.length,
              itemBuilder: (context, index) {
                final item = controller.myNotes![index];
                return GestureDetector(
                  onTap: () {
                    // print("object");
                    controller.coursetVisiblity(item: item);
                  },
                  child: NoteTile(
                    title: item.courseName,
                    notes: item.data,
                    totalNotes: item.totalNotes,
                    visible: item.isCourseVisible,
                    onSubjectClick: (subject) {
                      controller.subjectVisiblity(item: subject);
                    },
                    onTitleClick: (title) {
                      controller.titleVisiblity(item: title);
                    },
                    onSubTitleClick: (NoteBySubTitle title) {
                      controller.subTitleVisiblity(item: title);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => 10.height,
            );
          }
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
    required this.onSubjectClick,
    required this.onTitleClick,
    required this.totalNotes,
    required this.onSubTitleClick,
    required this.visible,
  });
  final String title;
  final List<NotesBySubject> notes;
  final Function(NotesBySubject subject) onSubjectClick;
  final Function(NoteByTitle title) onTitleClick;
  final Function(NoteBySubTitle title) onSubTitleClick;
  final int totalNotes;
  final bool visible;

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
          10.height,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // course name
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
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.scaffoldBg,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColor.textFeildBorderColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "$totalNotes Notes",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          10.height,

          // chapter
          Visibility(
            visible: visible,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: notes.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = notes[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => onSubjectClick(item),
                      child: Container(
                        width: double.maxFinite,
                        color: Colors.white,
                        // subject name
                        child: Row(
                          children: [
                            Text(
                              // "Overview and history algebra",
                              item.subjectName,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Visibility(visible: item.isChaptersVisbile, child: Icon(Icons.keyboard_arrow_down_rounded))
                          ],
                        ),
                      ),
                    ),
                    3.height,
                    // title

                    Visibility(
                      visible: item.isChaptersVisbile,
                      // title
                      child: ListView.separated(
                        // padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: item.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item2 = item.data[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => onTitleClick(item2),
                                child: Container(
                                  width: double.maxFinite,
                                  color: Colors.white,
                                  // subject name
                                  child: Row(
                                    children: [
                                      Text(
                                        // "Overview and history algebra",
                                        item2.title,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Visibility(visible: item2.isTitleVisbile, child: Icon(Icons.keyboard_arrow_down_rounded))
                                    ],
                                  ),
                                ),
                              ),

                              3.height,
                              // sub title
                              Visibility(
                                visible: item2.isTitleVisbile,
                                child: ListView.separated(
                                  itemCount: item2.data.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    final subTitle = item2.data[index];
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () => onSubTitleClick(subTitle),
                                          child: Container(
                                            width: double.maxFinite,
                                            color: Colors.white,
                                            // subject name
                                            child: Row(
                                              children: [
                                                Text(
                                                  subTitle.subTitle,
                                                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
                                                ),
                                                Visibility(visible: subTitle.isSubTitleVisbile, child: Icon(Icons.keyboard_arrow_down_rounded))
                                              ],
                                            ),
                                          ),
                                        ),
                                        4.height,
                                        // notes
                                        Visibility(
                                          visible: subTitle.isSubTitleVisbile,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: subTitle.data.length,
                                            itemBuilder: (context, index) {
                                              final note = subTitle.data[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return NoteDailog(noteData: note);
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
                                                          // notes[index].notes!,
                                                          note.notes ?? "",
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
                                              );
                                            },
                                            separatorBuilder: (context, index) => 8.height,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) => 2.height,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => 4.height,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => 0.height,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12),
          //   child: ListView.separated(
          //     itemCount: notes.length,
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemBuilder: (context, index) {
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             // "Overview and history algebra",
          //             notes[index].subtitle!,
          //             style: GoogleFonts.inter(
          //               fontSize: 14,
          //               fontWeight: FontWeight.w400,
          //             ),
          //           ),
          //           4.height,
          //           GestureDetector(
          //             onTap: () {
          //               showDialog(
          //                 context: context,
          //                 builder: (context) {
          //                   return NoteDailog(noteData: notes[index]);
          //                 },
          //               );
          //             },
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 color: AppColor.white,
          //                 border: Border.all(color: AppColor.softBorderColor),
          //                 borderRadius: BorderRadius.circular(4),
          //               ),
          //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          //               child: Row(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Icon(
          //                     Icons.note_rounded,
          //                     color: context.appTheme.colorScheme.primary,
          //                   ),
          //                   12.width,
          //                   Expanded(
          //                     child: Text(
          //                       // "“Sample Note”",
          //                       notes[index].notes!,
          //                       style: GoogleFonts.inter(
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.w400,
          //                       ),
          //                       maxLines: 2,
          //                       overflow: TextOverflow.ellipsis,
          //                     ),
          //                   ),
          //                   12.width,
          //                   Icon(Icons.copy_rounded),
          //                   12.width,
          //                   Icon(Icons.notes_rounded)
          //                 ],
          //               ),
          //             ),
          //           )
          //         ],
          //       );
          //     },
          //     separatorBuilder: (context, index) => 12.height,
          //   ),
          // ),
          10.height,
        ],
      ),
    );
  }
}
