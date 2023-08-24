// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../widgets/join_meeting_sheet.dart';
import '../widgets/meeting_tile.dart';

class MeetingsTab extends StatelessWidget {
  const MeetingsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      children: [
        Text(
          "Upcoming Meetings",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8),
          shrinkWrap: true,
          primary: false,
          itemCount: 2,
          itemBuilder: (context, index) {
            return MeetingsTile(
              title: "The Mysteries of Dark Matter",
              time: "Aug 9, 2023 - 6:00 pm",
              body: "An in-depth exploration of the unknown aspects of dark matter. Open Q&A at the end.",
              count: "45 attending",
              onItemClick: () {
                var currentContext = rootNavigator.currentContext!;

                showModalBottomSheet(
                  context: currentContext,
                  builder: (context) => MeetingJoinBottomSheet(),
                );
              },
            );
          },
          separatorBuilder: (context, index) => 8.height,
        ),
        Text(
          "Past Meetings",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8),
          shrinkWrap: true,
          primary: false,
          itemCount: 1,
          itemBuilder: (context, index) {
            return MeetingsTile(
              title: "Relativity and Its Applications",
              time: "July 25, 2023",
              body: "Detailed discussion on the theory of relativity and its modern-day implications.",
              duration: "1 hour 15 mins",
              count: "45 Listeners",
            );
          },
          separatorBuilder: (context, index) => 8.height,
        ),
      ],
    );
  }
}
