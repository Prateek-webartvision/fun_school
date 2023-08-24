// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class GroupChatMessageTile extends StatelessWidget {
  const GroupChatMessageTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColor.textFeildBorderColor,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                fit: BoxFit.cover,
              ),
            ),
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
                      "Leon Satterfield",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "10:10 PM",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Text(
                  "Just finished a productive day at work. How about you?",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
