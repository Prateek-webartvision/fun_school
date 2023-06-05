import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var xx = GoRouterState.of(context).extra;
    print(xx);
    // appRoutes.backButtonDispatcher.addCallback(() async {
    //   print("hello");
    //   return false;
    // });
    // print(v);
    return Scaffold();
  }
}
