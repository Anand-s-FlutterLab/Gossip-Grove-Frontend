import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/models/login_model.dart';
import 'package:gossip_grove/providers/chat_list_provider.dart';
import 'package:gossip_grove/providers/socket_provider.dart';
import 'package:gossip_grove/providers/user_provider.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  bool isLoginPressed = false;
  bool obscureText = true;

  void obscureTextToggle() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void loginToggle() {
    isLoginPressed = !isLoginPressed;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> onLogin({required BuildContext context}) async {
    loginToggle();
    LoginModel loginModel = LoginModel(
      email: emailController.text,
      password: passwordController.text,
    );
    try {
      Response response = await Dio().get(
        "$baseUrl/$authRoute",
        data: loginModel.toJson(),
      );
      if (response.data["success"]) {
        authToken = "Bearer ${response.data["token"]}";
        currentUserDetails.id = response.data["data"];
        currentUserDetails.notificationToken = FCMToken;
        writeStorage(storageAuthToken, authToken);
        writeStorage(storageUserId, currentUserDetails.id);
        if (!context.mounted) return;
        addToken(context: context);
      } else {
        if (!context.mounted) return;
        print("Login failed");
        customToastMessage(context: context, desc: response.data["data"]);
      }
    } catch (error) {
      print(error);

      if (!context.mounted) return;
      customToastMessage(context: context, desc: error.toString());
    }
  }

  Future<void> addToken({required BuildContext context}) async {
    try {
      Response response = await Dio().put(
        "$baseUrl/$addNotificationToken",
        data: {
          "notificationToken": FCMToken,
        },
        options: Options(
          headers: {"Authorization": authToken},
        ),
      );
      if (response.data["success"]) {
        if (!context.mounted) return;
        context.goNamed("home");
        Provider.of<UserProvider>(context, listen: false)
            .getUsers(context: context);
        Provider.of<ChatListProvider>(context, listen: false)
            .getChatList(context: context);
        Provider.of<SocketProvider>(context, listen: false).connectToServer();
        emailController.clear();
        passwordController.clear();
      } else {
        print("Notification token");
        if (!context.mounted) return;
        customToastMessage(context: context, desc: response.data["data"]);
      }
    } catch (error) {
      print(error);
      if (!context.mounted) return;
      customToastMessage(context: context, desc: error.toString());
    } finally {
      loginToggle();
    }
  }
}
