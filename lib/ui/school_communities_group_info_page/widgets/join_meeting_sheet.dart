// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../repo/community/community_group_repo.dart';
import '../../../style/color.dart';

class MeetingJoinBottomSheet extends StatelessWidget {
  const MeetingJoinBottomSheet({
    super.key,
    required this.meeting,
  });
  final GroupMeetingModel meeting;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: AppColor.white,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: AppColor.softBorderColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Meeting Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    // rootNavigator.currentState!.pop();
                    context.pop();
                  },
                  child: Icon(Icons.close_rounded),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: AppColor.softBorderColor),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Topic",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff1c1c1c),
                      ),
                    ),
                    Text(
                      // "The Mysteries of Dark Matter",

                      meeting.meetingTitle ?? "",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3C3C43).withOpacity(0.6),
                      ),
                    )
                  ],
                ),
                Divider(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "When",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff1c1c1c),
                      ),
                    ),
                    Text(
                      // "Aug 9, 2023 - 6:00 pm",
                      "${meeting.meetingDate} - ${meeting.meetingTime}",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3C3C43).withOpacity(0.6),
                      ),
                    )
                  ],
                ),
                Divider(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Duration",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff1c1c1c),
                      ),
                    ),
                    Text(
                      // "30 mins",
                      meeting.meetingDuration ?? "0",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3C3C43).withOpacity(0.6),
                      ),
                    )
                  ],
                ),
                Divider(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Host",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff1c1c1c),
                      ),
                    ),
                    Text(
                      // "John Doe",
                      meeting.meetingHost ?? "",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3C3C43).withOpacity(0.6),
                      ),
                    )
                  ],
                ),
                // Divider(height: 14),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Tasks",
                //       style: TextStyle(
                //         fontSize: 17,
                //         fontWeight: FontWeight.w400,
                //         color: Color(0xff1c1c1c),
                //       ),
                //     ),
                //     Text(
                //       "21 Tasks available",
                //       style: TextStyle(
                //         fontSize: 17,
                //         fontWeight: FontWeight.w400,
                //         color: Color(0xff3C3C43).withOpacity(0.6),
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    // bottom: BorderSide(color: AppColor.softBorderColor),
                    ),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                    fixedSize:
                        MaterialStatePropertyAll(Size(double.maxFinite, 44)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                    backgroundColor:
                        MaterialStatePropertyAll(AppColor.mainColor),
                    foregroundColor: MaterialStatePropertyAll(AppColor.white)),
                onPressed: () {
                  context.pop();
                  if (meeting.meetingLink != null) {
                    // AppUtils.showSnack(meeting.meetingLink ?? "");
                    launchUrl(Uri.parse(meeting.meetingLink!));
                  } else {
                    AppUtils.showSnack("Join link not found");
                  }
                },
                child: Text(
                  "Join meeting",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              )),
        ],
      ),
    );
  }
}
