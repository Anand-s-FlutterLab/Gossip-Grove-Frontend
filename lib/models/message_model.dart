class MessageModel {
  String chatId;
  String senderId;
  String sendTime;
  String date;
  String message;
  String chatType;

  MessageModel({
    required this.chatId,
    required this.senderId,
    required this.sendTime,
    required this.date,
    required this.message,
    required this.chatType,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    chatId: json["chatId"],
    senderId: json["senderId"],
    sendTime: json["sendTime"],
    date: json["date"],
    message: json["message"],
    chatType: json["chatType"],
  );

  Map<String, dynamic> toJson() => {
    "chatId": chatId,
    "senderId": senderId,
    "sendTime": sendTime,
    "date": date,
    "message": message,
    "chatType": chatType,
  };
}
