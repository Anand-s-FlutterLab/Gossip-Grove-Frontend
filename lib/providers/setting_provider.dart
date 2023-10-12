import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SettingProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? profileImage;

  bool isUpdating = false;

  @override
  void dispose() {
    super.dispose();
    onClose();
    nameController.dispose();
    statusController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  void settingToggle() {
    isUpdating = !isUpdating;
    notifyListeners();
  }

  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      notifyListeners();
    }
  }

  Future<String> uploadImage({required BuildContext context}) async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final File? image = profileImage;

      final String imagePath =
          '$collectionUsers/${currentUserDetails.id}/profileImage.jpg';

      UploadTask uploadTask = storage.ref().child(imagePath).putFile(image!);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print(error.toString());
      if (!context.mounted) return "";
      customToastMessage(context: context, desc: error.toString());
      return "";
    }
  }

  Future<void> updateUserProfile({required BuildContext context}) async {
    String profileURL = "";
    settingToggle();
    if (profileImage != null) {
      profileURL = await uploadImage(context: context);
    }
    try {
      Response response = await Dio().put(
        "$baseUrl/$updateUserDetails",
        data: {
          "username": nameController.text,
          "status": statusController.text,
          "phone": phoneController.text,
          "userProfileUrl": profileURL.isEmpty
              ? currentUserDetails.userProfileUrl
              : profileURL,
        },
        options: Options(
          headers: {"Authorization": authToken},
        ),
      );
      if (response.data["success"]) {
        currentUserDetails = UserModel.fromJson(response.data["data"]);
        notifyListeners();
        if (!context.mounted) return;
        customToastMessage(
            context: context, desc: profileUpdatedMessage, isSuccess: true);
      } else {
        if (!context.mounted) return;
        customToastMessage(context: context, desc: response.data["data"]);
      }
    } catch (error) {
      if (!context.mounted) return;
      customToastMessage(context: context, desc: error.toString());
    } finally {
      settingToggle();
    }
  }

  void onClose() {
    profileImage = null;
  }

  void onLogout() {
    clearStorage();
    currentUserDetails = UserModel(
      id: "",
      username: "",
      email: "",
      phone: "",
      userProfileUrl: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      v: 0,
      status: "",
      notificationToken: FCMToken,
    );
  }
}
