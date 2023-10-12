import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/models/signup_model.dart';
import 'package:gossip_grove/providers/chat_list_provider.dart';
import 'package:gossip_grove/providers/socket_provider.dart';
import 'package:gossip_grove/providers/user_provider.dart';

class SignupProvider with ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  bool isSignupPressed = false;
  bool obscureText = true;

  void obscureTextToggle() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void signupToggle() {
    isSignupPressed = !isSignupPressed;
    notifyListeners();
  }

  void onSignup({required BuildContext context}) async {
    signupToggle();
    SignupModel signupModel = SignupModel(
      status: "Hello there, I am using Gossip Grove",
      username: usernameController.text,
      email: emailController.text,
      phone: phoneNumberController.text,
      password: passwordController.text,
      userProfileUrl: "Not Set",
      notificationToken: FCMToken,
    );
    try {
      Response response = await Dio().post(
        "$baseUrl/$authRoute",
        data: signupModel.toJson(),
      );
      if (response.data["success"]) {
        writeStorage(storageAuthToken, response.data["token"]);
        authToken = "Bearer ${response.data["token"]}";
        currentUserDetails.id = response.data["data"];
        if (!context.mounted) return;
        context.pushReplacementNamed("home");
        Provider.of<UserProvider>(context, listen: false)
            .getUsers(context: context);
        Provider.of<ChatListProvider>(context, listen: false)
            .getChatList(context: context);
        Provider.of<SocketProvider>(context, listen: false).connectToServer();
      } else {
        if (!context.mounted) return;
        customToastMessage(context: context, desc: response.data["data"]);
      }
    } catch (error) {
      if (!context.mounted) return;
      customToastMessage(context: context, desc: error.toString());
    } finally {
      signupToggle();
    }
  }
}
