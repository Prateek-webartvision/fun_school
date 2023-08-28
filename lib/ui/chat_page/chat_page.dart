// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../style/assets.dart';
import '../../style/color.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageModel> chatMessage = [
    ChatMessageModel(message: "Thank you, I'll take a look now.", time: DateTime.now(), isMyMessage: true),
    ChatMessageModel(message: "Great to hear. Also, I've sent you the notes on quantum physics. Let me know if you have questions!", time: DateTime.now(), isMyMessage: false),
    ChatMessageModel(message: "Absolutely! I've prepped my questions.", time: DateTime.now(), isMyMessage: true),
    ChatMessageModel(message: "Hope you're doing well. Ready for our session tomorrow? User: Absolutely! I've prepped my questions.", time: DateTime.now(), isMyMessage: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text(
          "@TutorTina",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_rounded))],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              reverse: true,
              itemCount: chatMessage.length,
              itemBuilder: (context, index) {
                return ChatTile(
                  message: chatMessage[index].message,
                  isMyMessage: chatMessage[index].isMyMessage,
                );
              },
              separatorBuilder: (_, __) => 10.height,
            ),
          ), // bottom
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
                      print(value);
                    },
                  ),
                ),
                4.width,
                SvgPicture.asset(AppAssets.svg.attachmentIcon),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessageModel {
  final String message;
  final DateTime time;
  final bool isMyMessage;
  ChatMessageModel({
    required this.message,
    required this.time,
    required this.isMyMessage,
  });
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.message,
    this.time,
    this.isMyMessage = false,
  });
  final String message;
  final DateTime? time;
  final bool isMyMessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (isMyMessage) ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 303),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: (isMyMessage) ? AppColor.mainColor : Color(0xffF7F7F8),
          // borderRadius: BorderRadius.circular(15).copyWith(topLeft: (!isMyMessage)?Radius.circular(1):Radius.circular(15)),
          borderRadius: BorderRadius.only(
            topLeft: (!isMyMessage) ? Radius.circular(1) : Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topRight: (isMyMessage) ? Radius.circular(1) : Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(message,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: (isMyMessage) ? AppColor.white : Colors.black,
                )),

            //time
            Text(
              "10:05 PM",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: (isMyMessage) ? Color(0xff90C2FF) : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
