import 'package:gossip_grove/models/user_model.dart';

String authToken = "";

String FCMToken = "";

UserModel currentUserDetails = UserModel(
  id: "",
  username: "",
  email: "",
  phone: "",
  userProfileUrl: "",
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  v: 0,
  status: "",
  notificationToken: "",
);
