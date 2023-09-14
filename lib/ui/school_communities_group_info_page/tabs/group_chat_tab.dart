// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/assets.dart';
import '../../../style/color.dart';
import '../widgets/group_chat_tile.dart';

class GroupChatRoomTab extends StatelessWidget {
  const GroupChatRoomTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // chat List
      Expanded(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          itemCount: 3,
          reverse: true,
          itemBuilder: (context, index) {
            return GroupChatMessageTile();
          },
          separatorBuilder: (context, index) => 10.height,
        ),
      ),
      // chat text fiels and more
      Divider(color: AppColor.softBorderColor, height: 0),
      Container(
        height: 72,
        decoration: BoxDecoration(color: AppColor.white),
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets.svg.happyFaceIcon),
            4.width,
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: "Message",
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                onSubmitted: (value) {
                  // print(value);
                },
              ),
            ),
            4.width,
            SvgPicture.asset(AppAssets.svg.attachmentIcon),
          ],
        ),
      ),
    ]);
  }
}
