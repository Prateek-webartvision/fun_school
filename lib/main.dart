import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'router/app_router.dart';
import 'style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
