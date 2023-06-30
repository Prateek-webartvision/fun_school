import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotficationServices {
  static AppNotficationServices? _init;

  AppNotficationServices._() {
    _localNotifications = FlutterLocalNotificationsPlugin();
  }

  static AppNotficationServices get instance {
    return _init ??= AppNotficationServices._();
  }

  late FlutterLocalNotificationsPlugin _localNotifications;

  showNotifaction() async {
    AndroidInitializationSettings androidSettings = const AndroidInitializationSettings("mipmap/ic_launcher");
    InitializationSettings initializationSettings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(initializationSettings);
    _localNotifications.show(
      3,
      "abc",
      "message 3",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "kundan",
          "kundan noti",
          playSound: true,
          groupKey: "com.android.example.WORK_EMAIL",
          channelDescription: "kd",
          importance: Importance.max,
          setAsGroupSummary: true,
          showProgress: true,
        ),
      ),
    );
  }
}
