// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/subject.model.dart';
import '../widgets/chapter_tile.dart';

class ChaptersTab extends StatelessWidget {
  const ChaptersTab({
    super.key,
    this.subject,
  });
  final CoursesSubject? subject;

  @override
  Widget build(BuildContext context) {
    if (subject!.subjectContent!.isEmpty) {
      return Center(child: Text("No content to show"));
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: subject!.subjectContent!.length,
        itemBuilder: (context, index) {
          final chapter = subject!.subjectContent![index];
          // chapter tile
          return ChapterTile(
            title: chapter.first.title!,
            subjects: chapter,
          );
        },
        separatorBuilder: (context, index) => 12.height,
      );
    }
  }
}
