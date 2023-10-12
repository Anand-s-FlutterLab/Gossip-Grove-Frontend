import 'package:gossip_grove/core/app_export.dart';

Widget chatMessage({
  required String message,
  required String time,
  required bool sender,
}) {
  return Align(
    alignment: sender ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.all(getSize(10)),
      width: getHorizontalSize(250),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
        color: sender ? AppColor.userChatColor : WhiteColor.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          bottomLeft: const Radius.circular(12),
          bottomRight: Radius.circular(sender ? 0 : 12),
          topLeft: Radius.circular(sender ? 12 : 0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            text: message,
            color: sender ? WhiteColor.white : BlackColor.charcoalBlack,
            fontSize: getFontSize(17),
            maxLines: 30,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: getVerticalSize(5),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: customText(
              text: time,
              color: sender ? WhiteColor.smokeWhite : GrayColor.gray,
              fontSize: getFontSize(12),
            ),
          ),
        ],
      ),
    ),
  );
}
