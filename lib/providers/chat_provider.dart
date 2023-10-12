import 'dart:async';

import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/models/chat_model.dart';
import 'package:gossip_grove/providers/socket_provider.dart';

class ChatProvider with ChangeNotifier {
  bool isChatLoading = false;
  bool emptyChat = false;
  final ScrollController controller = ScrollController();

  late Chat chat;
  TextEditingController messageController = TextEditingController();

  void chatToggle() {
    isChatLoading = !isChatLoading;
    notifyListeners();
  }

  void scrollDown() {
    Timer(Duration(milliseconds: 50), () {
      controller.jumpTo(controller.position.maxScrollExtent);
    });
  }

  Future<void> getChatByID(
      {required BuildContext context, required String chatId}) async {
    final socketProvider = Provider.of<SocketProvider>(context, listen: false);
    try {
      chatToggle();
      socketProvider.joinRoom(chatId: chatId);
      emptyChat = false;
      notifyListeners();
      Response response = await Dio().get(
        "$baseUrl/$startChat",
        data: {"chatId": chatId},
        options: Options(
          headers: {"Authorization": authToken},
        ),
      );

      if (response.data["success"] &&
          response.data["data"] == "No Messages in this conversation") {
        emptyChat = true;

        notifyListeners();
      } else if (response.data["success"]) {
        chat = Chat.fromJson(response.data["data"]);
        notifyListeners();
      } else {
        if (!context.mounted) return;
        customToastMessage(context: context, desc: response.data["data"]);
      }
      scrollDown();
    } catch (error) {
      print(error);
      if (!context.mounted) return;
      customToastMessage(context: context, desc: error.toString());
    } finally {
      chatToggle();
    }
  }

  Future<void> sendMessage({
    required BuildContext context,
    required String chatId,
    required String receiverId,
    required String receiverToken,
  }) async {
    final socketProvider = Provider.of<SocketProvider>(context, listen: false);
    try {
      SendMessageModel sendMessageModel = SendMessageModel(
        chatId: chatId,
        receiverId: receiverId,
        senderId: currentUserDetails.id,
        sendTime: formatSendTime(),
        date: formatSendDate(),
        message: messageController.text,
        chatType: "one-on-one",
      );
      Response response = await Dio().post("$baseUrl/$startChat",
          data: sendMessageModel.toJson(),
          options: Options(
            headers: {"Authorization": authToken},
          ));
      if (response.data["success"]) {
        if (!context.mounted) return;
        FocusScope.of(context).unfocus();
        messageController.clear();
        socketProvider.sendMessage(
          chat: chat,
          message: sendMessageModel,
          receiverToken: receiverToken,
        );
        notifyListeners();
      } else {
        if (!context.mounted) return;
        customToastMessage(context: context, desc: response.data["data"]);
      }
    } catch (error) {
      if (!context.mounted) return;
      customToastMessage(context: context, desc: error.toString());
    }
  }

  void addNewMessage(Map<String, dynamic> data) {
    final message = SendMessageModel.fromJson(data);
    final chats = chat.chats;
    if (chats.containsKey(message.date)) {
      chats[message.date].add(Message(
          senderId: message.senderId,
          sendTime: message.sendTime,
          message: message.message));
      notifyListeners();
      scrollDown();
    } else {
      chats[message.date] = [
        Message(
            senderId: message.senderId,
            sendTime: message.sendTime,
            message: message.message)
      ];
      notifyListeners();
      scrollDown();
    }
  }
}
