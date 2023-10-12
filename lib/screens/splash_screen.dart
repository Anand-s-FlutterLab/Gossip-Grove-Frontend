import 'dart:async';

import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/providers/chat_list_provider.dart';
import 'package:gossip_grove/providers/socket_provider.dart';
import 'package:gossip_grove/providers/user_provider.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> fadeInFadeOut;
  String routeName = "";

  @override
  void initState() {
    super.initState();

    getInitData();

    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);
    animation.forward();

    Timer(
      Duration(seconds: 3),
      () => context.goNamed(routeName),
    );
  }

  void getInitData() async {
    authToken = await readStorage(storageAuthToken) ?? "";
    currentUserDetails.id = await readStorage(storageUserId) ?? "";
    if (authToken.isNotEmpty || currentUserDetails.id.isNotEmpty) {
      routeName = "home";
      currentUserDetails.notificationToken = FCMToken;
      Provider.of<UserProvider>(context, listen: false)
          .getUsers(context: context);
      Provider.of<ChatListProvider>(context, listen: false)
          .getChatList(context: context);
      Provider.of<SocketProvider>(context, listen: false).connectToServer();
    } else {
      routeName = "login";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: fadeInFadeOut,
                child: customText(
                  text: "Gossip Grove",
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                  fontSize: getFontSize(45),
                ),
              ),
              SizedBox(
                height: getVerticalSize(100),
              ),
              Transform.scale(
                scale: 1.5,
                child: Lottie.asset(
                  SplashImage.message_splash,
                  repeat: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
