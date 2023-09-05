import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/community_discussion_model/community_discussion_model.dart';
import '../style/color.dart';

class OverlapingUserAvtar extends StatelessWidget {
  const OverlapingUserAvtar({
    super.key,
    required this.likes,
    this.radius = 16,
    this.maxAvtatCount = 0,
  });

  final List<Likes> likes;
  final double radius;
  final int maxAvtatCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (likes.length > maxAvtatCount) ? maxAvtatCount : likes.length,
        (index) {
          return Align(
            widthFactor: 0.6,
            child: Container(
              height: radius,
              width: radius,
              decoration: BoxDecoration(
                color: AppColor.softBorderColor,
                border: Border.all(color: AppColor.white),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(likes[index].userProfileImage!),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          );
        },
      ),
    );
  }
}
