// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../models/courses_dedails/subject.model.dart';
import '../controller/subject_state_controller.dart';
import '../widgets/chapter_tile.dart';
import '../widgets/subject_state_selector.dart';

enum SubjectState { video, quiz, flashcard }

class ChaptersTab extends StatefulWidget {
  const ChaptersTab({
    super.key,
    this.subject,
  });
  final CoursesSubject? subject;

  @override
  State<ChaptersTab> createState() => _ChaptersTabState();
}

class _ChaptersTabState extends State<ChaptersTab> {
  late SubjectStateController stateController;

  @override
  void initState() {
    stateController = SubjectStateController(state: SubjectState.flashcard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.subject!.subjectContent!.isEmpty) {
      return Center(child: Text("coming soon"));
    } else {
      return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPadding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              sliver: SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: stateController,
                  builder: (context, child) {
                    return SubjectStateSlector(
                      state: stateController.state,
                      onChange: (state) {
                        stateController.updateState(state);
                      },
                    );
                  },
                ),
              ),
            ),
          ];
        },
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: widget.subject!.subjectContent!.length,
          itemBuilder: (context, index) {
            final chapter = widget.subject!.subjectContent![index];
            // chapter tile
            return AnimatedBuilder(
              animation: stateController,
              builder: (context, child) {
                return ChapterTile(
                  flashCard: widget.subject!.flashCard!,
                  title: chapter.first.title!,
                  subjects: chapter,
                  state: stateController.state,
                );
              },
            );
          },
          separatorBuilder: (context, index) => 12.height,
        ),
      );
    }
  }
}
