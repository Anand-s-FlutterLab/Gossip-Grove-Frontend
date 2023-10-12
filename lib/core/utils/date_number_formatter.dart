import 'package:intl/intl.dart';

String formatPhoneNumber(String phoneNumber) {
  final number = phoneNumber.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
  final formattedNumber =
      '+91 ${number.substring(0, 5)} ${number.substring(5)}';
  return formattedNumber;
}

String formatSendTime() {
  DateTime now = DateTime.now();
  String formattedTime = DateFormat.Hm().format(now);
  return formattedTime;
}

String formatSendDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('d MMMM, yyyy').format(now);
  return formattedDate;
}
