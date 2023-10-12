import 'package:gossip_grove/core/app_export.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

void customToastMessage({
  required BuildContext context,
  required String desc,
  bool isSuccess = false,
}) {
  return MotionToast(
    description: customText(
      color: isSuccess ? GreenColor.green : RedColor.cardinalRed,
      fontWeight: FontWeight.bold,
      text: desc,
      fontSize: getFontSize(15),
    ),
    iconSize: getFontSize(30),
    primaryColor: isSuccess ? GreenColor.green : RedColor.cardinalRed,
    width: getHorizontalSize(350),
    height: getVerticalSize(40),
    displayBorder: true,
    borderRadius: 12,
    animationCurve: Curves.fastLinearToSlowEaseIn,
    displaySideBar: true,
    icon: isSuccess ? Icons.task_alt_rounded : Icons.warning_rounded,
    animationType: AnimationType.fromBottom,
    dismissable: true,
    backgroundType: BackgroundType.lighter,
  ).show(context);
}
