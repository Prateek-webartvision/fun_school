// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../style/const.dart';

class MockSubmitPdfPage extends StatefulWidget {
  const MockSubmitPdfPage({super.key});

  @override
  State<MockSubmitPdfPage> createState() => _MockSubmitPdfPageState();
}

class _MockSubmitPdfPageState extends State<MockSubmitPdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTextStyle.appBarText,
        title: Text("Exam Preparation"),
        centerTitle: true,
      ),
    );
  }
}
