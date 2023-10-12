class UserModel {
  String id;
  String username;
  String email;
  String phone;
  String userProfileUrl;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String notificationToken;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.userProfileUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.status,
    required this.notificationToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        userProfileUrl: json["userProfileUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        status: json["status"],
        notificationToken: json["notificationToken"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "phone": phone,
        "userProfileUrl": userProfileUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "status": status,
        "notificationToken": notificationToken
      };
}
