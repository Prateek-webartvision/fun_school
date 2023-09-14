import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseFGnotification(RemoteMessage message) async {
  await AppLocalNotification.instence.showNotifaction(
    title: message.notification?.title,
    message: message.notification?.body,
  );
}

Future<void> firebaseBGMessages(RemoteMessage message) async {
  await Firebase.initializeApp();
  await AppLocalNotification.instence.showNotifaction(
    title: message.notification?.title,
    message: message.notification?.body,
  );
}

const String _flutterNotificationChennalName = "App Notification";
const String _flutterNotificationChennalId = "AN1";

class AppLocalNotification {
  static AppLocalNotification? _init;

  late FlutterLocalNotificationsPlugin _localNotifications;

  AppLocalNotification._() {
    _notiInit();
  }

  static AppLocalNotification get instence => _init ??= AppLocalNotification._();

  Future _notiInit() async {
    _localNotifications = FlutterLocalNotificationsPlugin();
    // ANDROID NOTIFICATION ICON
    AndroidInitializationSettings androidSettings = const AndroidInitializationSettings("mipmap/noti_logo");
    //
    final InitializationSettings initializationSettings = InitializationSettings(android: androidSettings);
    //
    await _localNotifications.initialize(initializationSettings);
  }

  // SHOW ALL FIREBASE NOTIFICATIONS
  showNotifaction({String? title, String? message}) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _flutterNotificationChennalId,
        _flutterNotificationChennalName,
        playSound: true,
        importance: Importance.max,
        priority: Priority.max,
      ),
    );

    await _localNotifications.show(
      6,
      title,
      message,
      notificationDetails,
    );

    // await _localNotifications.periodicallyShow(id, title, body, repeatInterval, notificationDetails);
  }
}
