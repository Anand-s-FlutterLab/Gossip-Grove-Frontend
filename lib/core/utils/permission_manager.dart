import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

void notificationPermissionManager() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

Future<bool> storagePermissionManager() async {
  final permissionStatus = await Permission.storage.status;
  if (permissionStatus.isDenied) {
    await Permission.storage.request();
    if (permissionStatus.isDenied) {
      await openAppSettings();
    }
  } else if (permissionStatus.isPermanentlyDenied) {
    await openAppSettings();
  } else {
    return true;
  }
  return false;
}
