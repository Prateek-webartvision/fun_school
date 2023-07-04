import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseBGMessages(
  RemoteMessage message,
  // required InitializationSettings initializationSettings,
  // required FlutterLocalNotificationsPlugin localNotifications,
) async {
  AppNotficationServices.instance.showNotifaction(title: message.notification?.title, message: message.notification?.body);
  // await localNotifications.initialize(initializationSettings);
  // localNotifications.show(
  //   2,
  //   message.notification!.title,
  //   message.notification!.body,
  //   const NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       "kundan",
  //       "kundan noti",
  //       playSound: true,
  //       groupKey: "com.android.example.WORK_EMAIL",
  //       channelDescription: "kd",
  //       importance: Importance.max,
  //       setAsGroupSummary: true,
  //       showProgress: true,
  //     ),
  //   ),
  // );
}

class AppNotficationServices {
  static AppNotficationServices? _init;

  AppNotficationServices._() {
    _localNotifications = FlutterLocalNotificationsPlugin();
    _firebaseMessaging = FirebaseMessaging.instance;
    _initializationSettings = InitializationSettings(android: androidSettings);
    _firebaseNoficationServices();
  }

  static AppNotficationServices get instance {
    return _init ??= AppNotficationServices._();
  }

  AndroidInitializationSettings androidSettings = const AndroidInitializationSettings("mipmap/ic_launcher");

  late FirebaseMessaging _firebaseMessaging;
  late FlutterLocalNotificationsPlugin _localNotifications;
  late InitializationSettings _initializationSettings;

  Future _firebaseNoficationServices() async {
    await _firebaseMessaging.requestPermission();
    // final fcmToken = await _firebaseMessaging.getToken();

    FirebaseMessaging.onBackgroundMessage(firebaseBGMessages);

    FirebaseMessaging.onMessage.listen((event) async {
      await _localNotifications.initialize(_initializationSettings);

      _localNotifications.show(
        1,
        event.notification?.title,
        event.notification?.body,
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
    });
  }

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
