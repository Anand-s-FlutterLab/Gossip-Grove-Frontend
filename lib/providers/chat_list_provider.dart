import 'package:gossip_grove/core/app_export.dart';

class ChatListProvider with ChangeNotifier {
  bool isChatListLoading = false;
  List<String> userIdList = [];

  void chatLoadingToggle() {
    isChatListLoading = !isChatListLoading;
    notifyListeners();
  }

  Future<void> getChatList({required BuildContext context}) async {
    userIdList.clear();
    chatLoadingToggle();
    try {
      Response response = await Dio().get(
        "$baseUrl/$getChatListByUID",
        options: Options(
          headers: {"Authorization": authToken},
        ),
      );
      if (response.data["success"]) {
        String currentUserID = response.data["userID"];
        for (var i in response.data["data"]) {
          List<String> idSplit = i.split("_");
          if (idSplit[0] != currentUserID) {
            userIdList.add(idSplit[0]);
          } else {
            userIdList.add(idSplit[1]);
          }
        }
      } else {
        if (!context.mounted) return;
        customToastMessage(context: context, desc: response.data["data"]);
      }
    } catch (error) {
      if (!context.mounted) return;
      customToastMessage(context: context, desc: error.toString());
    } finally {
      chatLoadingToggle();
    }
  }
}
