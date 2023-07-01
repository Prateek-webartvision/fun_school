// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NoQuizFoundWidget extends StatelessWidget {
  const NoQuizFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("No Quiz found"),
      ),
    );
  }
}
