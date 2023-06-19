import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'style/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
