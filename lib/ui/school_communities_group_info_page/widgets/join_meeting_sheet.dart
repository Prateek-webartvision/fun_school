// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../repo/community/community_group_repo.dart';
import '../../../style/color.dart';
import '../../../widgets/k_btn.dart';
import '../../../widgets/k_text_field.dart';
import '../school_communities_group_info_page.dart';

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
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(
                              Size(double.maxFinite, 44)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          backgroundColor:
                              MaterialStatePropertyAll(AppColor.mainColor),
                          foregroundColor:
                              MaterialStatePropertyAll(AppColor.white)),
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
                        "Join Meeting",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    )),
              ),
              //

              // edit
              if (meeting.meetingHostId ==
                  AppStorage.user.current?.userId?.toString())
                Expanded(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(
                                Size(double.maxFinite, 44)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            backgroundColor:
                                MaterialStatePropertyAll(AppColor.mainColor),
                            foregroundColor:
                                MaterialStatePropertyAll(AppColor.white)),
                        onPressed: () {
                          context.pop();
                          AppUtils.showModelSheet(
                            child: EditMeetingSheet(
                              meetingID: meeting.meetingId ?? "",
                              topic: meeting.meetingTitle ?? "",
                              des: meeting.meetingDescription ?? "",
                              link: meeting.meetingLink ?? "",
                              time: meeting.meetingTime ?? "",
                              date: meeting.meetingDate ?? "",
                              duration: meeting.meetingDuration ?? "",
                            ),
                            shape: BeveledRectangleBorder(),
                            isScrolled: true,
                          );
                        },
                        child: Text(
                          "Edit Meeting",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class EditMeetingSheet extends StatefulWidget {
  const EditMeetingSheet({
    super.key,
    required this.meetingID,
    required this.topic,
    required this.des,
    required this.duration,
    required this.date,
    required this.time,
    required this.link,
  });
  final String meetingID;
  final String topic;
  final String des;
  final String duration;
  final String date;
  final String time;
  final String link;

  @override
  State<EditMeetingSheet> createState() => _EditMeetingSheet();
}

class _EditMeetingSheet extends State<EditMeetingSheet> {
  final TextEditingController title = TextEditingController();
  final TextEditingController des = TextEditingController();
  final TextEditingController link = TextEditingController();
  final TextEditingController duration = TextEditingController();
  final TextEditingController date = TextEditingController();
  DateTime? selectedDate;
  final TextEditingController time = TextEditingController();
  TimeOfDay? selectedTime;
  String errorMessage = "";

  @override
  void initState() {
    title.text = widget.topic;
    des.text = widget.des;
    link.text = widget.link;
    duration.text = widget.duration;
    // date Time
    date.text = widget.date;
    final dateList = widget.date.split("-");
    selectedDate = DateTime(
        int.parse(dateList[2]), int.parse(dateList[1]), int.parse(dateList[0]));

    // time of Day
    time.text = widget.time;
    final tt = (widget.time).split(':');
    final t2 = tt.last.split(' ');
    final String h = tt.first;
    final String min = t2.first;
    final String a = t2.last;

    if (a == "PM") {
      selectedTime = TimeOfDay(hour: int.parse(h) + 12, minute: int.parse(min));
    } else {
      selectedTime = TimeOfDay(hour: int.parse(h), minute: int.parse(min));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: double.maxFinite,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin:
            EdgeInsets.only(bottom: (MediaQuery.of(context).viewInsets.bottom)),
        child: ListView(
          shrinkWrap: true,
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Create New Meeting",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(Icons.close),
                )
              ],
            ),
            //
            20.height,
            KTextField(
              hint: "Title",
              controller: title,
            ),
            10.height,
            KTextField(
              hint: "Description",
              controller: des,
            ),
            10.height,
            KTextField(
              hint: "Meeting Link",
              controller: link,
            ),
            10.height,
            KTextField(
              hint: "Duration in Min",
              controller: duration,
              textInputType: TextInputType.number,
            ),
            10.height,
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    Duration(days: 30),
                  ),
                );
                if (date != null) {
                  // log(date.toString());
                  selectedDate = date;
                  this.date.text =
                      DateFormat("MMM dd, yyyy").format(selectedDate!);
                }
              },
              child: KTextField(
                hint: "Meeting Date",
                enabled: false,
                controller: date,
              ),
            ),
            10.height,
            InkWell(
              onTap: () async {
                selectedTime = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());

                time.text = TimeOfDay(
                  hour: selectedTime!.hour,
                  minute: selectedTime!.minute,
                  // ignore: use_build_context_synchronously
                ).format(context);
              },
              child: KTextField(
                hint: "Meeting Time",
                enabled: false,
                controller: time,
              ),
            ),
            if (errorMessage.isNotEmpty) 10.height,
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            20.height,
            KBtn(
              onClick: () async {
                if (title.text.isEmpty ||
                    des.text.isEmpty ||
                    date.text.isEmpty ||
                    time.text.isEmpty ||
                    duration.text.isEmpty ||
                    link.text.isEmpty) {
                  setState(() {
                    errorMessage = "Enter All Fields";
                  });
                  Future.delayed(
                    Duration(seconds: 2),
                    () {
                      setState(() {
                        errorMessage = "";
                      });
                    },
                  );
                } else {
                  AppUtils.showLoadingOverlay(() async {
                    try {
                      await CommunityGroupRepository.updateMeeting(
                        title: title.text.trim(),
                        des: des.text.trim(),
                        meetingDate: selectedDate!,
                        meetingTime: selectedTime!,
                        duration: duration.text.trim(),
                        link: link.text.trim(),
                        meetingID: widget.meetingID,
                      );
                      await Get.find<GroupMeetingController>().reLoad;
                      // ignore: use_build_context_synchronously
                      context.pop();
                    } catch (e) {
                      setState(() {
                        errorMessage = e.toString();
                      });
                      // AppUtils.showSnack(e.toString());
                    }
                  });
                }
              },
              text: "Create Meeting",
            )
          ],
        ),
      );
    });
  }
}
