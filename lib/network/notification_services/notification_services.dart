import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseFGnotification(RemoteMessage message) async {
  await AppLocalNotification.instence.showNotifaction(title: message.notification?.title, message: message.notification?.body);
}

Future<void> firebaseBGMessages(RemoteMessage message) async {
  await Firebase.initializeApp();
  await AppLocalNotification.instence.showNotifaction(title: message.notification?.title, message: message.notification?.body);
}

class AppLocalNotification {
  late FlutterLocalNotificationsPlugin _localNotifications;
  late InitializationSettings _initializationSettings;
  AndroidInitializationSettings androidSettings = const AndroidInitializationSettings("mipmap/noti_logo");

  static AppLocalNotification? _init;

  AppLocalNotification._() {
    _localNotifications = FlutterLocalNotificationsPlugin();
    _initializationSettings = InitializationSettings(android: androidSettings);
  }

  static AppLocalNotification get instence => _init ??= AppLocalNotification._();

  showNotifaction({
    String? title,
    String? message,
  }) async {
    await _localNotifications.initialize(_initializationSettings);
    _localNotifications.show(
      3,
      title,
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "t",
          "tt",
          playSound: true,
          importance: Importance.max,
          setAsGroupSummary: true,
          showProgress: true,
        ),
      ),
    );
  }
}
