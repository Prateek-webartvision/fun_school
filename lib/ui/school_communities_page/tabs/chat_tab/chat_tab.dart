// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../router/app_router.dart';
import '../../../../style/assets.dart';
import '../../../../style/color.dart';
import '../../../chat_page/chat_page.dart';
import '../../widgets/chat_user_tile.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.softBorderColor),
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              SvgPicture.asset(AppAssets.svg.search),
              8.width,
              Text(
                "Search Messages",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
        17.height,
        ListView.separated(
          shrinkWrap: true,
          itemCount: 3,
          primary: false,
          itemBuilder: (context, index) {
            return ChatUserTile(
              onTap: () {
                // print("object");
                rootNavigator.currentState!.push(MaterialPageRoute(builder: (_) => ChatPage()));
                // Get.to(() => ChatPage());
              },
            );
          },
          separatorBuilder: (_, __) => 17.height,
        ),
      ],
    );
  }
}
