import 'dart:convert';
import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/models/user_model.dart';
import 'package:gossip_grove/providers/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.id1, super.key});

  final String id1;

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = UserModel.fromJson(
      jsonDecode(id1),
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: getVerticalSize(55),
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        leadingWidth: getHorizontalSize(30),
        leading: IconButton(
          icon: const Center(child: Icon(Icons.arrow_back)),
          onPressed: () {
            context.pop();
          },
        ),
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.pushNamed(
                  "chat_user_profile",
                  extra: currentUser.toJson(),
                );
              },
              child: Container(
                height: getVerticalSize(45),
                width: getHorizontalSize(45),
                decoration: const BoxDecoration(
                    color: GrayColor.lightGray, shape: BoxShape.circle),
                child: Hero(
                  tag: "ProfileImage_${currentUser.email}",
                  child: customImageView(
                    url: currentUser.userProfileUrl == "Not Set"
                        ? ChatImages.individualChatImage
                        : currentUser.userProfileUrl,
                    imgHeight: getVerticalSize(45),
                    imgWidth: width,
                    borderRadius: 30,
                    isAssetImage:
                        currentUser.userProfileUrl == "Not Set" ? true : false,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: getHorizontalSize(10),
            ),
            customText(
              color: WhiteColor.white,
              fontSize: getFontSize(25),
              fontWeight: FontWeight.bold,
              text: currentUser.username,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height - getVerticalSize(55),
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ChatImages.chatBackgroundPattern,
              ),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child:
              Consumer<ChatProvider>(builder: (context, chatProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                chatProvider.isChatLoading
                    ? Center(
                        child: customPageLoadingAnimation(
                          size: getSize(50),
                        ),
                      )
                    : chatProvider.emptyChat
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            height: getVerticalSize(670),
                            child: Center(
                              child: customText(
                                text:
                                    "Start the conversation with a friendly 'Hello' or share something interesting with ${currentUser.username}.",
                                maxLines: 5,
                                fontSize: getFontSize(20),
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : SizedBox(
                            height: getVerticalSize(670),
                            child: ListView.separated(
                              controller: chatProvider.controller,
                              padding: EdgeInsets.all(
                                getSize(20),
                              ),
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, parentIndex) {
                                final currentChat = chatProvider
                                    .chat.chats.entries
                                    .elementAt(parentIndex);
                                return Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                          getHorizontalSize(10),
                                          getVerticalSize(5),
                                          getHorizontalSize(10),
                                          getVerticalSize(5),
                                        ),
                                        decoration: BoxDecoration(
                                            color: WhiteColor.white,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black38,
                                                blurRadius: 3,
                                                offset: Offset(3, 3),
                                              )
                                            ]),
                                        child: customText(
                                          text: currentChat.key,
                                          color: AppColor.primaryColor,
                                          fontSize: getFontSize(17),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(15),
                                    ),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return chatMessage(
                                          message:
                                              currentChat.value[index].message,
                                          sender: currentChat
                                                  .value[index].senderId ==
                                              currentUserDetails.id,
                                          time:
                                              currentChat.value[index].sendTime,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: getVerticalSize(10),
                                        );
                                      },
                                      itemCount: currentChat.value.length,
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: getVerticalSize(20),
                                );
                              },
                              itemCount: chatProvider.chat.chats.keys.length,
                            ),
                          ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    getSize(10),
                    getSize(0),
                    getSize(10),
                    getSize(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: getVerticalSize(50),
                          child: TextField(
                            cursorColor: WhiteColor.white,
                            keyboardType: TextInputType.text,
                            controller: chatProvider.messageController,
                            style: AppStyle.textFormFieldStyle(
                              color: WhiteColor.white,
                              fontSize: getFontSize(18),
                            ),
                            decoration: AppDecoration().textInputDecoration(
                              hintText: "Message",
                              lableText: "Message",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getHorizontalSize(10),
                      ),
                      GestureDetector(
                        onTap: () {
                          List chatIds = [
                            currentUser.id,
                            currentUserDetails.id
                          ];
                          chatIds.sort();
                          chatProvider.sendMessage(
                            context: context,
                            chatId: chatIds.join("_"),
                            receiverId: currentUser.id,
                            receiverToken: currentUser.notificationToken,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.primaryColor,
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            color: WhiteColor.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
