// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/ui/school_communities_page/controllers/chat_user_controller.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../../router/app_router.dart';
import '../../../../style/assets.dart';
import '../../../../style/color.dart';
import '../../../../widgets/error_page.dart';
import '../../../chat_page/chat_page.dart';
import '../../widgets/chat_user_tile.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({
    super.key,
    required this.controller,
  });

  final ChatUserController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
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
        return Padding(
          // padding: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
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
              if (controller.users == null || controller.users!.isEmpty)
                Expanded(child: Center(child: Text("No chats to show")))
              else
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => await controller.reLoad(),
                    child: ListView.separated(
                      // shrinkWrap: true,
                      itemCount: controller.users!.length,
                      // primary: false,
                      itemBuilder: (context, index) {
                        final user = controller.users![index];
                        // return Text("data ${user.profileImage}");
                        return ChatUserTile(
                          name: user.username ?? "",
                          lastMessage: user.lastMessage ?? "",
                          profileImage: user.profileImage,
                          timeStamp: user.lastMessageTime!,
                          onTap: () {
                            final String myID =
                                AppStorage.user.current?.userId?.toString() ??
                                    "";
                            String receiverId;
                            if (user.sendBy == myID) {
                              receiverId = user.sendTo.toString();
                            } else {
                              receiverId = user.sendBy.toString();
                            }
                            // * send to chat page
                            rootNavigator.currentState!.push(
                              MaterialPageRoute(
                                builder: (_) => ChatPage(
                                  profileUrl: user.profileImage,
                                  receiverID: receiverId,
                                  userName: user.username ?? "",
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (_, __) => 17.height,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
