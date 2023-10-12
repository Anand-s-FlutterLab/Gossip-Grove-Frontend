import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/models/user_model.dart';

class UserProvider with ChangeNotifier {
  Map<String, UserModel> users = {};

  bool isUserFetching = false;

  void userToggle() {
    isUserFetching = !isUserFetching;
    notifyListeners();
  }

  Future<void> getUsers({required BuildContext context}) async {
    userToggle();
    users.clear();
    try {
      Response response = await Dio().get(
        "$baseUrl/$getAllUsers",
        options: Options(
          headers: {"Authorization": authToken},
        ),
      );
      if (response.data["success"]) {
        for (var i in response.data["data"]) {
          users[i["_id"]] = UserModel.fromJson(i as Map<String, dynamic>);
          notifyListeners();
        }
        currentUserDetails = users[currentUserDetails.id]!;
      }
    } catch (error) {
      print(error);
      if (!context.mounted) return;
      customToastMessage(context: context, desc: error.toString());
    } finally {
      userToggle();
    }
  }
}
