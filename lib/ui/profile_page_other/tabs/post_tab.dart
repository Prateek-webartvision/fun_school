// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets/post_tile.dart';

class PostTab extends StatelessWidget {
  const PostTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return PostTile(
          profileUrl: "https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg",
          userName: "userName",
          time: DateTime.now().subtract(Duration(minutes: 33)).toString(),
          message: "What's the real difference between 4G and 5G?",
        );
      },
      separatorBuilder: (_, __) => Divider(
        height: 0,
      ),
      itemCount: 8,
    );
  }
}
