class Chat {
  String id;
  String chatId;
  String chatType;
  Map<String, dynamic> chats;
  int v;

  Chat({
    required this.id,
    required this.chatId,
    required this.chatType,
    required this.chats,
    required this.v,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    var chatMessages = json['chats'];
    Map<String, List<Message>> messages = <String, List<Message>>{};
    for (var i in chatMessages.keys) {
      for (var j = 0; j < chatMessages[i].length; j++) {
        if (messages.containsKey(i)) {
          messages[i]!.add(Message.fromJson(chatMessages[i][j]));
        } else {
          messages[i] = [Message.fromJson(chatMessages[i][j])];
        }
      }
    }
    return Chat(
      id: json['_id'],
      chatId: json['chatId'],
      chatType: json['chatType'],
      chats: messages,
      v: json['__v'],
    );
  }
}

class Message {
  String senderId;
  String sendTime;
  String message;

  Message({
    required this.senderId,
    required this.sendTime,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      sendTime: json['sendTime'],
      message: json['message'],
    );
  }
}

class SendMessageModel {
  String chatId;
  String senderId;
  String receiverId;
  String sendTime;
  String date;
  String message;
  String chatType;

  SendMessageModel({
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.sendTime,
    required this.date,
    required this.message,
    required this.chatType,
  });

  factory SendMessageModel.fromJson(Map<String, dynamic> json) =>
      SendMessageModel(
        chatId: json["chatId"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        sendTime: json["sendTime"],
        date: json["date"],
        message: json["message"],
        chatType: json["chatType"],
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "senderId": senderId,
        "receiverId": receiverId,
        "sendTime": sendTime,
        "date": date,
        "message": message,
        "chatType": chatType,
      };
}
