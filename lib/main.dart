import 'package:firebase_core/firebase_core.dart';
import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/core/utils/permission_manager.dart';
import 'package:gossip_grove/providers/chat_list_provider.dart';
import 'package:gossip_grove/providers/chat_provider.dart';
import 'package:gossip_grove/providers/login_provider.dart';
import 'package:gossip_grove/providers/setting_provider.dart';
import 'package:gossip_grove/providers/signup_provider.dart';
import 'package:gossip_grove/providers/socket_provider.dart';
import 'package:gossip_grove/providers/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.instance.getToken().then((value) {
    FCMToken = value!;
  });

  notificationPermissionManager();

  runApp(const GossipGrove());
}

class GossipGrove extends StatelessWidget {
  const GossipGrove({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignupProvider>(
          create: (context) => SignupProvider(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<ChatListProvider>(
          create: (context) => ChatListProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider<SocketProvider>(
          create: (context) => SocketProvider(context),
        ),
        ChangeNotifierProvider<SettingProvider>(
          create: (context) => SettingProvider(),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}
