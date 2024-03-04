import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_storage/get_storage.dart';

import 'network/firebase_options.dart';
import 'network/notification_services/notification_services.dart';
import 'router/app_router.dart';
import 'style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  late FirebaseOptions options;
  if (Platform.isAndroid == true) {
    options = DefaultFirebaseOptions.android;
  } else {
    options = DefaultFirebaseOptions.ios;
  }

  await Firebase.initializeApp(options: options);

  FirebaseAnalytics.instance;
  FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(firebaseBGMessages);
  FirebaseMessaging.onMessage.listen(firebaseFGnotification);

  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldManagerKey,
      title: 'Fun School',
      theme: AppTheme.light,
      routerConfig: appRoutes,
    );
  }
}
