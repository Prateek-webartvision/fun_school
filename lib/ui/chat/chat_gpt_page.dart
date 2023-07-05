// ignore_for_file: prefer_const_constructors

import 'package:citycloud_school/network/url/app_urls.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class ChatGptPage extends StatefulWidget {
  const ChatGptPage({super.key});

  @override
  State<ChatGptPage> createState() => _ChatGptPageState();
}

class _ChatGptPageState extends State<ChatGptPage> {
  List<AppChatModel> demoChat = [
    AppChatModel(isAi: false, message: "Hey!", data: DateTime.now()),
    AppChatModel(isAi: true, message: "Hey there! Can I help you", data: DateTime.now()),
  ];

  TextEditingController messageTextController = TextEditingController();
  late OpenAI openAI;
  @override
  void initState() {
    openAI = OpenAI.instance.build(token: AppUrls.chatGPTKey);
    // openAI = a
    // chatRequest();
    super.initState();
  }

  chatRequest() async {
    final request = CompleteText(prompt: 'What is human life expectancy in the United States?', model: TextDavinci3Model(), maxTokens: 200);

    final response = await openAI.onCompletion(request: request);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Fun School"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: demoChat.length,
              itemBuilder: (context, index) {
                return MessageBoxWidget(
                  chat: demoChat[index],
                );
              },
              separatorBuilder: (context, index) => 10.height,
            ),
          ),
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
                        demoChat.add(AppChatModel(isAi: false, message: messageTextController.text, data: DateTime.now()));
                        messageTextController.clear();
                        setState(() {});
                        await Future.delayed(Duration(milliseconds: 600));
                        demoChat.add(AppChatModel(isAi: true, message: "demo ai message", data: DateTime.now()));
                        setState(() {});
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

class AppChatModel {
  final bool isAi;
  final String message;
  final DateTime data;

  AppChatModel({required this.isAi, required this.message, required this.data});
}
