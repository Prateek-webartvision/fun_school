// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controller/my_notes_controller.dart';

class NoteDailog extends StatelessWidget {
  const NoteDailog({
    super.key,
    required this.noteData,
  });
  final NotesModel noteData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 44,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.center,
                      child: Text(
                        noteData.subtitle!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(Icons.close)),
                  )
                ],
              ),
            ),
            Divider(height: 0),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                noteData.notes!,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
