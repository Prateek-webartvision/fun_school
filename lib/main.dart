import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'network/firebase_options.dart';
import 'network/notification_services/notification_services.dart';
import 'router/app_router.dart';
import 'style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppNotficationServices.instance;
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMenagerKey,
      title: 'Fun School',
      theme: AppTheme.light,
      routerConfig: appRoutes,
    );
  }
}
