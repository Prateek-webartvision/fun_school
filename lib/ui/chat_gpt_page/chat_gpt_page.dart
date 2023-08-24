// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/ui/chat_gpt_page/controller/chat_gpt_controller.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kd_utils/kd_utils.dart';

class ChatGptPage extends StatefulWidget {
  const ChatGptPage({super.key});

  @override
  State<ChatGptPage> createState() => _ChatGptPageState();
}

class _ChatGptPageState extends State<ChatGptPage> {
  TextEditingController messageTextController = TextEditingController();
  late ChatGptController chatGptController;

  @override
  void initState() {
    chatGptController = ChatGptController();
    Get.lazyPut(() => chatGptController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColor.scaffoldBg,
        centerTitle: true,
        title: const Text("Fun School"),
      ),
      body: GetBuilder(
        init: chatGptController,
        builder: (controller) {
          return Column(
            children: [
              Container(
                // height: 76,
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(),
                    Text(
                      "Welcome!",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "This is the beginning Of your BOT AI for your school!",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: controller.scrollController,
                  padding: EdgeInsets.all(16),
                  itemCount: controller.demoChat.length,
                  itemBuilder: (context, index) {
                    return MessageBoxWidget(
                      chat: controller.demoChat[index],
                    );
                  },
                  separatorBuilder: (context, index) => 10.height,
                ),
              ),
              (controller.apiState == ApiState.loading) ? Text("Loading...") : 0.height,
              Container(
                // height: 100,
                color: AppColor.scaffoldBg,
                // color: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextField(
                  controller: messageTextController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    hintText: "Write your message here",
                    // isCollapsed: true,
                    suffixIcon: GestureDetector(
                        onTap: () async {
                          if (messageTextController.text.isEmpty) {
                            AppUtils.showSnack("write message");
                          } else {
                            chatGptController.sendRequest(text: messageTextController.text);
                            messageTextController.clear();
                          }
                        },
                        child: Icon(Icons.send)),
                    border: _border(),
                    focusedBorder: _border(),
                    disabledBorder: _border(),
                    enabledBorder: _border(),
                    errorBorder: _border(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  OutlineInputBorder _border() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColor.softBorderColor),
      );
}

class MessageBoxWidget extends StatelessWidget {
  const MessageBoxWidget({
    super.key,
    required this.chat,
  });
  final AppChatModel chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: (chat.isAi) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 0, maxWidth: context.screenWidth * 0.7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColor.scaffoldBg),
          ),
          // alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Text(
            chat.message,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        2.height,
        Text(
          // "2:00 pm",
          DateFormat("h:mm a").format(chat.data),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
