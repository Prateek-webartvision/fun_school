// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/assets.dart';
import '../../../style/color.dart';
import '../controller/group_messages.controller.dart';
import '../controller/image_picker.controller.dart';
import '../controller/send_message_controller.dart';
import '../widgets/group_chat_tile.dart';

class GroupChatRoomTab extends StatefulWidget {
  const GroupChatRoomTab({
    super.key,
    required this.controller,
  });
  final GroupMessageController controller;

  @override
  State<GroupChatRoomTab> createState() => _GroupChatRoomTabState();
}

class _GroupChatRoomTabState extends State<GroupChatRoomTab> {
  TextEditingController message = TextEditingController();
  ImagePickerController imagePickerController = ImagePickerController();
  SendGroupChatController sendGroupChatController = SendGroupChatController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: widget.controller,
        builder: (controller) {
          if (controller.state == ApiState.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.state == ApiState.error) {
            return SizedBox();
          }
          return Column(
            children: [
              // chat List
              if (controller.messages.isEmpty)
                Expanded(
                  child: Center(
                    child: Text("No Messages"),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    itemCount: controller.messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final msg = controller.messages[index];
                      return GroupChatMessageTile(
                        name: msg.messageOwnerUsername ?? "",
                        message: msg.text ?? "",
                        time: msg.dateSent,
                        profile: msg.messageOwnerProfile,
                        image: msg.media,
                      );
                    },
                    separatorBuilder: (context, index) => 10.height,
                  ),
                ),
              // chat text fields and more
              GetBuilder(
                  init: sendGroupChatController,
                  builder: (mController) {
                    if (mController.state == ApiState.loading) {
                      return LinearProgressIndicator();
                    } else {
                      return Divider(
                          color: AppColor.softBorderColor, height: 0);
                    }
                  }),
              GetBuilder(
                  init: imagePickerController,
                  builder: (imgController) {
                    return Container(
                      // height: 72,
                      decoration: BoxDecoration(color: AppColor.white),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      child: Column(
                        children: [
                          // Text(imagePickerController.image.toString()),
                          if (imgController.image != null)
                            Image.file(
                              File(imgController.image!.path!),
                              height: 200,
                              fit: BoxFit.fitHeight,
                            ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // SvgPicture.asset(AppAssets.svg.happyFaceIcon),
                              GestureDetector(
                                onTap: () {
                                  imagePickerController.pick();
                                },
                                child: SvgPicture.asset(
                                    AppAssets.svg.attachmentIcon),
                              ),
                              4.width,
                              Expanded(
                                child: TextField(
                                  controller: message,
                                  minLines: 1,
                                  maxLines: 4,
                                  keyboardType: TextInputType.multiline,
                                  // textInputAction: TextInputAction.send,
                                  decoration: InputDecoration(
                                    hintText: "Message",
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 5),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                              4.width,
                              GestureDetector(
                                onTap: () async {
                                  //
                                  sendGroupChatController.sendMessage(
                                    message: message,
                                    imageCnt: imgController,
                                    groupID: controller.groupID,
                                  );
                                },
                                child: SvgPicture.asset(
                                  AppAssets.svg.sendIcon,
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          );
        });
  }
}
