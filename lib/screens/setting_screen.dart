import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/core/utils/permission_manager.dart';
import 'package:gossip_grove/providers/setting_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(getSize(20)),
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                        settingProvider.onClose();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: getSize(30),
                      ),
                    ),
                    customTitleText(
                      text: "Setting",
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: getFontSize(30),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return alertDialog(
                              context: context,
                              settingProvider: settingProvider,
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.logout_rounded,
                        size: getSize(30),
                        color: RedColor.cadmiumRed,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getVerticalSize(20),
                ),
                GestureDetector(
                  onTap: () async {
                    if (await storagePermissionManager()) {
                      settingProvider.openImagePicker();
                    } else {
                      if (!context.mounted) return;
                      customToastMessage(
                        context: context,
                        desc: storagePermissionError,
                      );
                    }
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _buildImagePicker(settingProvider),
                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: WhiteColor.white,
                              width: 4,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(getSize(5)),
                            child: const Icon(
                              Icons.edit_rounded,
                              color: WhiteColor.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getVerticalSize(50),
                ),
                Container(
                  decoration: AppDecoration.inputBoxDecorationShadow(),
                  child: TextFormField(
                    style: AppStyle.textFormFieldStyle(
                      fontSize: getFontSize(20),
                      color: BlackColor.jetBlack,
                    ),
                    controller: settingProvider.nameController
                      ..text = currentUserDetails.username,
                    decoration: AppDecoration().textInputDecorationWhite(
                      lableText: "Name",
                      icon: Icons.person,
                      hintText: "Enter Name Here",
                    ),
                  ),
                ),
                SizedBox(
                  height: getVerticalSize(20),
                ),
                Container(
                  decoration: AppDecoration.inputBoxDecorationShadow(),
                  child: TextFormField(
                    style: AppStyle.textFormFieldStyle(
                      fontSize: getFontSize(20),
                      color: BlackColor.jetBlack,
                    ),
                    controller: settingProvider.statusController
                      ..text = currentUserDetails.status,
                    maxLines: null,
                    decoration: AppDecoration().textInputDecorationWhite(
                      lableText: "Status",
                      icon: Icons.description_rounded,
                      hintText: "Enter Status Here",
                    ),
                  ),
                ),
                SizedBox(
                  height: getVerticalSize(20),
                ),
                Container(
                  decoration: AppDecoration.inputBoxDecorationShadow(),
                  child: TextFormField(
                    style: AppStyle.textFormFieldStyle(
                      fontSize: getFontSize(20),
                      color: BlackColor.jetBlack,
                    ),
                    controller: settingProvider.phoneController
                      ..text = currentUserDetails.phone,
                    decoration: AppDecoration().textInputDecorationWhite(
                      lableText: "Phone Number",
                      icon: Icons.phone_rounded,
                      hintText: "Enter Phone Number Here",
                    ),
                  ),
                ),
                SizedBox(
                  height: getVerticalSize(20),
                ),
                _buildTextInputField(
                    hintText: "",
                    icon: Icons.email_rounded,
                    controller: settingProvider.emailController
                      ..text = currentUserDetails.email,
                    labelText: '',
                    errorMessage: "",
                    readOnly: true),
                SizedBox(
                  height: getVerticalSize(30),
                ),
                GestureDetector(
                  onTap: () {
                    settingProvider.updateUserProfile(context: context);
                  },
                  child: Container(
                    height: getVerticalSize(50),
                    decoration: AppDecoration.containerBoxDecoration(),
                    child: Center(
                      child: settingProvider.isUpdating
                          ? customButtonLoadingAnimation(
                              size: getSize(50),
                            )
                          : customText(
                              text: "Update",
                              color: WhiteColor.white,
                              fontWeight: FontWeight.w500,
                              fontSize: getFontSize(23),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getVerticalSize(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildImagePicker(SettingProvider settingProvider) {
  return SizedBox(
    width: width * 0.5,
    height: height * 0.25,
    child: Container(
      decoration: AppDecoration.inputBoxDecorationShadow(),
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        width: height * 0.2,
        height: height * 0.25,
        decoration: BoxDecoration(
          color: WhiteColor.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: settingProvider.profileImage != null
            ? Image.file(settingProvider.profileImage!, fit: BoxFit.cover)
            : customImageView(
                url: currentUserDetails.userProfileUrl == "Not Set"
                    ? ChatImages.individualChatImage
                    : currentUserDetails.userProfileUrl,
                imgHeight: height * 0.25,
                isAssetImage: currentUserDetails.userProfileUrl == "Not Set",
                imgWidth: width * 0.5,
                fit: BoxFit.cover,
              ),
      ),
    ),
  );
}

Widget _buildTextInputField({
  required String labelText,
  required String hintText,
  required TextEditingController controller,
  required String errorMessage,
  required IconData icon,
  bool maxLine = false,
  bool readOnly = false,
  TextInputType textInputType = TextInputType.text,
}) {
  return Container(
    width: width,
    decoration: AppDecoration.inputBoxDecorationShadow(),
    child: TextFormField(
      readOnly: readOnly,
      style: AppStyle.textFormFieldStyle(fontSize: width * 0.05),
      keyboardType: textInputType,
      maxLines: maxLine ? null : 1,
      decoration: AppDecoration().textInputDecorationWhite(
        lableText: labelText,
        icon: icon,
        hintText: hintText,
        color: readOnly ? GrayColor.sliver : WhiteColor.white,
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return errorMessage;
        }
        return null;
      },
    ),
  );
}

Widget alertDialog({
  required BuildContext context,
  required SettingProvider settingProvider,
}) {
  return AlertDialog(
    title: customTitleText(
      text: "Alert",
      color: AppColor.primaryColor,
      fontSize: getFontSize(22),
      fontWeight: FontWeight.bold,
    ),
    content: customText(
      text: "Are you sure want to logout?",
      color: BlackColor.charcoalBlack,
      fontSize: getFontSize(18),
    ),
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    actions: [
      TextButton(
        onPressed: () {
          context.pop();
        },
        child: Container(
          padding: EdgeInsets.all(getSize(14)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: customText(
            text: "Cancel",
            fontSize: getFontSize(15),
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          context.goNamed("login");
          settingProvider.onLogout();
        },
        child: Container(
          padding: EdgeInsets.all(getSize(14)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                RedColor.cadmiumRed,
                RedColor.bloodRed,
              ],
            ),
          ),
          child: customText(
            text: "Logout",
            fontSize: getFontSize(15),
            color: WhiteColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
