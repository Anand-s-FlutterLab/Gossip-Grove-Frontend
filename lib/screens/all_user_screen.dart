import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/providers/chat_list_provider.dart';
import 'package:gossip_grove/providers/chat_provider.dart';
import 'package:gossip_grove/providers/user_provider.dart';

class AllUserScreen extends StatelessWidget {
  const AllUserScreen({super.key});

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
                  left: getHorizontalSize(10),
                  right: getHorizontalSize(20),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<ChatListProvider>(context, listen: false)
                            .getChatList(context: context);
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: WhiteColor.offWhite,
                        size: getFontSize(28),
                      ),
                    ),
                    SizedBox(
                      width: getHorizontalSize(10),
                    ),
                    customText(
                      text: "New Message",
                      fontSize: getFontSize(30),
                      color: WhiteColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.search_rounded,
                      color: WhiteColor.offWhite,
                      size: getFontSize(28),
                    ),
                    SizedBox(
                      width: getHorizontalSize(15),
                    ),
                    GestureDetector(
                      onTap: () {
                        userProvider.getUsers(context: context);
                      },
                      child: Icon(
                        Icons.refresh_rounded,
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
                  child: userProvider.isUserFetching
                      ? Center(
                          child: customPageLoadingAnimation(
                            size: getSize(45),
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            var currentUser = userProvider.users.entries
                                .elementAt(index)
                                .value;
                            if (currentUser.id == currentUserDetails.id) {
                              return const SizedBox();
                            }
                            return ListTile(
                              onTap: () {
                                List chatIds = [
                                  currentUser.id,
                                  currentUserDetails.id
                                ];
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
                              title: customText(
                                text: currentUser.username,
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
                                    tag: "ProfileImage_${currentUser.email}",
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
                          itemCount: userProvider.users.keys.length,
                          padding: EdgeInsets.only(
                            right: getHorizontalSize(10),
                            bottom: getHorizontalSize(10),
                          ),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: getVerticalSize(userProvider.users.entries
                                          .elementAt(index)
                                          .value
                                          .id ==
                                      currentUserDetails.id
                                  ? 0
                                  : 10),
                            );
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
