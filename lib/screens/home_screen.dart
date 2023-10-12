import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/providers/chat_list_provider.dart';
import 'package:gossip_grove/providers/chat_provider.dart';
import 'package:gossip_grove/providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColor.primaryGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getVerticalSize(15),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: getHorizontalSize(20),
                  right: getHorizontalSize(20),
                ),
                child: Row(
                  children: [
                    customText(
                      text: "Gossip Grove",
                      fontSize: getFontSize(30),
                      color: WhiteColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed("setting");
                      },
                      child: Icon(
                        Icons.settings,
                        color: WhiteColor.offWhite,
                        size: getFontSize(28),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: getVerticalSize(20),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: getHorizontalSize(20),
                  ),
                  decoration: const BoxDecoration(
                    color: WhiteColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Consumer<ChatListProvider>(
                    builder: (context, chatListProvider, child) {
                      if (userProvider.isUserFetching ||
                          chatListProvider.isChatListLoading) {
                        return Center(
                          child: customPageLoadingAnimation(size: 50),
                        );
                      }
                      return chatListProvider.userIdList.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.message_rounded,
                                    color: AppColor.primaryColor,
                                    size: getFontSize(50),
                                    shadows: const [
                                      Shadow(
                                        color: GrayColor.ashGrey,
                                        blurRadius: 2,
                                        offset: Offset(2, 2),
                                      )
                                    ],
                                  ),
                                  customText(
                                    text:
                                        "Tap 'New Conversation' and start chatting with friends or colleagues! 🚀✨",
                                    maxLines: 5,
                                    color: BlackColor.matte,
                                    fontSize: getFontSize(20),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.only(
                                right: getHorizontalSize(10),
                                bottom: getHorizontalSize(10),
                              ),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final currentUser = userProvider
                                    .users[chatListProvider.userIdList[index]];
                                return ListTile(
                                  onTap: () {
                                    List chatIds = [
                                      currentUser.id,
                                      currentUserDetails.id
                                    ];
                                    chatIds.sort();
                                    Provider.of<ChatProvider>(context,
                                            listen: false)
                                        .getChatByID(
                                      context: context,
                                      chatId: chatIds.join("_"),
                                    );
                                    context.pushNamed(
                                      "chat",
                                      extra: currentUser.toJson(),
                                    );
                                  },
                                  title: customText(
                                    text: currentUser!.username,
                                    textAlign: TextAlign.start,
                                    color: BlackColor.jetBlack,
                                    fontSize: getFontSize(20),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  subtitle: customText(
                                    text: currentUser.status,
                                    textAlign: TextAlign.start,
                                    color: GrayColor.gray,
                                    fontSize: getFontSize(17),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  leading: GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                        "chat_user_profile",
                                        extra: currentUser.toJson(),
                                      );
                                    },
                                    child: Container(
                                      height: getVerticalSize(45),
                                      width: getVerticalSize(45),
                                      decoration: BoxDecoration(
                                        color: GrayColor.lightGray,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Hero(
                                        tag:
                                            "ProfileImage_${currentUser.email}",
                                        child: customImageView(
                                          url: currentUser.userProfileUrl ==
                                                  "Not Set"
                                              ? ChatImages.individualChatImage
                                              : currentUser.userProfileUrl,
                                          imgHeight: getVerticalSize(45),
                                          imgWidth: getVerticalSize(45),
                                          fit: BoxFit.cover,
                                          isAssetImage:
                                              currentUser.userProfileUrl ==
                                                      "Not Set"
                                                  ? true
                                                  : false,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(color: GrayColor.darkGray),
                              itemCount: chatListProvider.userIdList.length,
                            );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
          context.pushNamed("allUser");
        },
        child: Icon(
          Icons.message_rounded,
          color: WhiteColor.white,
          size: getFontSize(30),
        ),
      ),
    );
  }
}
