import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../network/url/app_urls.dart';

class ChatGptController extends GetxController {
  late OpenAI openAI;
  ApiState? apiState;
  ScrollController scrollController = ScrollController();

  List<AppChatModel> demoChat = [
    AppChatModel(isAi: false, message: "Hey!", data: DateTime.now()),
    AppChatModel(isAi: true, message: "Hey there! Can I help you", data: DateTime.now()),
  ];

  ChatGptController() {
    openAI = OpenAI.instance.build(token: AppUrls.chatGPTKey);
    // scrollController.addListener(() {
    //   print(scrollController.position.maxScrollExtent);
    // });
  }

  @override
  dispose() {
    scrollController.dispose();
    super.dispose();
  }

  sendRequest({required String text}) async {
    // demoChat.clear();
    demoChat.add(AppChatModel(isAi: false, message: text, data: DateTime.now()));
    update();
    _goToEndScroll();
    _getResponce(text);
  }

  _getResponce(String text) async {
    final request = CompleteText(prompt: text, model: TextDavinci3Model(), maxTokens: 200);
    CompleteResponse? response;
    apiState = ApiState.loading;
    update();
    try {
      response = await openAI.onCompletion(request: request);
      demoChat.add(AppChatModel(isAi: true, message: response?.choices.first.text.trim() ?? "", data: DateTime.now()));
    } on OpenAIRateLimitError catch (e) {
      demoChat.add(AppChatModel(isAi: true, message: e.data?.error.message ?? "", data: DateTime.now()));
    } catch (e) {
      demoChat.add(AppChatModel(isAi: true, message: "Something wrong try layter", data: DateTime.now()));
      debugPrint(e.toString());
    }
    apiState = ApiState.success;
    _goToEndScroll();
    update();
  }

  _goToEndScroll() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }
}

class AppChatModel {
  final bool isAi;
  final String message;
  final DateTime data;

  AppChatModel({required this.isAi, required this.message, required this.data});
}
