import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:get/state_manager.dart';

import '../../../network/url/app_urls.dart';

class ChatGptController extends GetxController {
  late OpenAI openAI;
  List<AppChatModel> demoChat = [
    AppChatModel(isAi: false, message: "Hey!", data: DateTime.now()),
    AppChatModel(isAi: true, message: "Hey there! Can I help you", data: DateTime.now()),
  ];

  ChatGptController() {
    openAI = OpenAI.instance.build(token: AppUrls.chatGPTKey);
  }

  sendRequest({required String text}) async {
    demoChat.clear();
    // demoChat.add(AppChatModel(isAi: false, message: text, data: DateTime.now()));

    // final request = CompleteText(prompt: 'what is dart', model: TextDavinci3Model(), maxTokens: 100);

    // response = await openAI.onCompletion(request: request);
    update();
  }

  //  var rr = response as CompleteResponse?;
  //   print(rr?.choices.first.text);
}

class AppChatModel {
  final bool isAi;
  final String message;
  final DateTime data;

  AppChatModel({required this.isAi, required this.message, required this.data});
}
