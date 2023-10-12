class SignupModel {
  String username;
  String email;
  String phone;
  String password;
  String userProfileUrl;
  String status;
  String notificationToken;

  SignupModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.userProfileUrl,
    required this.status,
    required this.notificationToken,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        userProfileUrl: json["userProfileUrl"],
        status: json["status"],
        notificationToken: json["notificationToken"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone": phone,
        "password": password,
        "userProfileUrl": userProfileUrl,
        "status": status,
        "notificationToken": notificationToken
      };
}
