import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/models/chat_model.dart';
import 'package:gossip_grove/providers/chat_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider with ChangeNotifier {
  late IO.Socket socket;

  BuildContext context;

  SocketProvider(this.context);

  Future<void> connectToServer() async {
    socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.emit('join', currentUserDetails.id);
    socket.on('message', (data) {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      chatProvider.addNewMessage(data);
    });
    notifyListeners();
  }

  Future<void> joinRoom({required String chatId}) async {
    socket.emit('join_room', chatId);
  }

  Future<void> sendMessage({
    required Chat chat,
    required SendMessageModel message,
    required String receiverToken,
  }) async {
    socket.emit("message", {
      "chatId": message.chatId,
      "senderId": message.senderId,
      "receiverId": message.receiverId,
      "sendTime": message.sendTime,
      "date": message.date,
      "message": message.message,
      "chatType": message.chatType,
      "receiverToken": receiverToken,
      "senderName": currentUserDetails.username,
    });
    final chats = chat.chats;
    if (chats.containsKey(message.date)) {
      chats[message.date].add(Message(
          senderId: message.senderId,
          sendTime: message.sendTime,
          message: message.message));
      notifyListeners();
    } else {
      chats[message.date] = [
        Message(
            senderId: message.senderId,
            sendTime: message.sendTime,
            message: message.message)
      ];
      notifyListeners();
    }
  }
}
