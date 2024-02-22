// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class ChatUserTile extends StatelessWidget {
  const ChatUserTile({
    super.key,
    required this.onTap,
    required this.name,
    required this.lastMessage,
    this.profileImage,
    required this.timeStamp,
  });
  final Function() onTap;
  final String name;
  final String lastMessage;
  final String? profileImage;
  final int timeStamp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* profile image

          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColor.softBorderColor,
              borderRadius: BorderRadius.circular(100),
              image: (profileImage != null && profileImage != "")
                  ? DecorationImage(
                      image: CachedNetworkImageProvider(
                        profileImage!,
                        // "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: (profileImage != null && profileImage != "")
                ? null
                : Icon(
                    Icons.person_rounded,
                    color: Colors.black54,
                  ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // "Tutor Tina",
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  // "Thanks for the resource links! They were super helpful.",
                  lastMessage,
                  style:
                      TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          Text(
            timeago.format(getDateTimeFromTimeStamp(timeStamp: timeStamp)),
            // DateFormat("hh:mm a")
            //     .format(getDateTimeFromTimeStamp(timeStamp: timeStamp)),
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
