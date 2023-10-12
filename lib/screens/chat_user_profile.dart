import 'dart:convert';

import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/models/user_model.dart';
import 'package:gossip_grove/providers/chat_provider.dart';

class ChatUserProfile extends StatelessWidget {
  final String id1;

  const ChatUserProfile({required this.id1, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = UserModel.fromJson(jsonDecode(id1));
    return Scaffold(
      backgroundColor: WhiteColor.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            child: Container(
              color: GrayColor.lightGray,
              height: getVerticalSize(465),
              child: Hero(
                tag: "ProfileImage_${currentUser.email}",
                child: customImageView(
                  url: currentUser.userProfileUrl == "Not Set"
                      ? ChatImages.individualChatImage
                      : currentUser.userProfileUrl,
                  imgHeight: getVerticalSize(465),
                  imgWidth: width,
                  isAssetImage:
                      currentUser.userProfileUrl == "Not Set" ? true : false,
                  borderRadius: 0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: getVerticalSize(50),
            left: getHorizontalSize(20),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                  padding: EdgeInsets.all(
                    getSize(7),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back)),
            ),
          ),
          Positioned(
            left: 0,
            top: getVerticalSize(400),
            child: Container(
              width: width,
              padding: EdgeInsets.all(
                getSize(24),
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    70,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getSize(10),
                  ),
                  customText(
                    text: currentUser.username,
                    textAlign: TextAlign.start,
                    color: AppColor.primaryColor,
                    fontSize: getFontSize(35),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: getSize(20),
                  ),
                  customText(
                    text: currentUser.status,
                    textAlign: TextAlign.start,
                    color: BlackColor.charcoalBlack,
                    fontSize: getFontSize(22),
                    maxLinesEnabled: true,
                  ),
                  SizedBox(
                    height: getSize(3),
                  ),
                  customText(
                    text: "Status",
                    textAlign: TextAlign.start,
                    color: GrayColor.ashGrey,
                    fontSize: getFontSize(17),
                  ),
                  SizedBox(
                    height: getSize(20),
                  ),
                  customText(
                    text: formatPhoneNumber(currentUser.phone),
                    textAlign: TextAlign.start,
                    color: BlackColor.charcoalBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: getFontSize(25),
                  ),
                  customText(
                    text: "Mobile",
                    textAlign: TextAlign.start,
                    color: GrayColor.ashGrey,
                    fontSize: getFontSize(17),
                  ),
                  SizedBox(
                    height: getSize(20),
                  ),
                  customText(
                      text: currentUser.email,
                      textAlign: TextAlign.start,
                      color: BlackColor.charcoalBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: getFontSize(25),
                      maxLines: 3),
                  customText(
                    text: "Email",
                    textAlign: TextAlign.start,
                    color: GrayColor.ashGrey,
                    fontSize: getFontSize(17),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: getVerticalSize(375),
            child: GestureDetector(
              onTap: () {
                List chatIds = [currentUser.id, currentUserDetails.id];
                chatIds.sort();
                Provider.of<ChatProvider>(
                  context,
                  listen: false,
                ).getChatByID(
                  context: context,
                  chatId: chatIds.join("_"),
                );
                context.pushNamed(
                  "chat",
                  extra: currentUser.toJson(),
                );
              },
              child: Container(
                padding: EdgeInsets.all(
                  getSize(15),
                ),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5,
                      offset: Offset(5, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.primaryColor,
                ),
                child: Icon(
                  Icons.message_rounded,
                  color: WhiteColor.white,
                  size: getFontSize(25),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
