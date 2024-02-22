// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../repo/chat_repo/chat_repo.dart';
import '../../style/assets.dart';
import '../../style/color.dart';
import '../../widgets/error_page.dart';
import 'controller/messages_by_user_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.receiverID,
    required this.profileUrl,
    required this.userName,
  });
  final String receiverID;
  final String? profileUrl;
  final String userName;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late MessagesByUserController messagesByUserController;
  TextEditingController myMessage = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    messagesByUserController =
        MessagesByUserController(receiverID: widget.receiverID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text(
          // "@TutorTina",
          widget.userName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_rounded))
        ],
      ),
      body: GetBuilder(
        init: messagesByUserController,
        builder: (controller) {
          if (controller.state == ApiState.loading) {
            return Center(child: CircularProgressIndicator());
          }
          // on error
          if (controller.state == ApiState.error) {
            return ErrorPage(
              error: controller.error,
              onError: () {
                controller.initLoad();
              },
            );
          }
          // on success
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  reverse: true,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller
                        .messages[(controller.messages.length - 1) - index];
                    // return Text("data ${message.message}");
                    return ChatTile(
                      message: message.message ?? "",
                      isMyMessage: (message.sendBy != widget.receiverID),
                      time: message.time,
                    );
                  },
                  separatorBuilder: (_, __) => 10.height,
                ),
              ),
              //* bottom
              Divider(color: AppColor.softBorderColor, height: 0),
              //* message box
              Container(
                decoration: BoxDecoration(color: AppColor.white),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // SvgPicture.asset(AppAssets.svg.happyFaceIcon),

                    // SvgPicture.asset(AppAssets.svg.attachmentIcon),
                    4.width,
                    Expanded(
                      child: TextField(
                        controller: myMessage,
                        keyboardType: TextInputType.multiline,
                        // textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 4,
                        style: TextStyle(
                          height: 0.95,
                        ),

                        decoration: InputDecoration(
                          hintText: "Message",
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        // onSubmitted: (value) async {},
                      ),
                    ),
                    // 4.width,
                    InkWell(
                      onTap: () async {
                        // send text message
                        if (myMessage.text.isNotEmpty) {
                          await ChatRepository.sendMessage(
                            receiverID: widget.receiverID,
                            message: myMessage.text.trim(),
                          );
                          myMessage.clear();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        // padding:
                        //     EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 6,
                            left: 5,
                            right: 5,
                            bottom: 3,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.svg.sendIcon,
                            height: 28,
                            width: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    messagesByUserController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}

class ChatMessageModel {
  String? messageID;
  String? sendBy;
  String? sendTo;
  String? message;
  int? time;

  ChatMessageModel({
    this.messageID,
    this.sendBy,
    this.sendTo,
    this.message,
    this.time,
  });
  ChatMessageModel.fromJson(json) {
    messageID = json['message_id'];
    sendBy = json['sender_id'];
    sendTo = json['receiver_id'];
    message = json['message'];
    time = json['time'];
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.message,
    this.time,
    this.isMyMessage = false,
  });
  final String message;
  final int? time;
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
              // "10:05 PM",
              timeago.format(getDateTimeFromTimeStamp(timeStamp: time!)),
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
