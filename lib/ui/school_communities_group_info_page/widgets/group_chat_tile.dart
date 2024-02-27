// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import 'package:timeago/timeago.dart' as ago;

class GroupChatMessageTile extends StatelessWidget {
  const GroupChatMessageTile({
    super.key,
    required this.name,
    required this.message,
    this.time,
    this.profile,
    this.image,
  });
  final String name;
  final String message;
  final dynamic time;
  final String? profile;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColor.textFeildBorderColor,
              borderRadius: BorderRadius.circular(20),
              image: (profile != null)
                  ? DecorationImage(
                      image: NetworkImage(
                          // "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                          profile!.toString()),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: (profile != null) ? null : Icon(Icons.person),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // "Leon Satterfield",
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      // "10:10 PM",
                      ago.format(timeStampToDateTime(time)),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                6.height,
                if (message.isNotEmpty)
                  Text(
                    // "Just finished a productive day at work. How about you?",
                    message,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                if (image != null)
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 100,
                      maxHeight: 200,
                    ),
                    // decoration: BoxDecoration(
                    //   color: Colors.green,
                    // ),
                    child: CachedNetworkImage(imageUrl: image!),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
