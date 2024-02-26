import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../style/color.dart';

class OverlayUserAvatar extends StatelessWidget {
  const OverlayUserAvatar({
    super.key,
    required this.avatarUrls,
    this.radius = 16,
    this.maxAvatarCount = 0,
  });

  final List<String> avatarUrls;
  final double radius;
  final int maxAvatarCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (avatarUrls.length > maxAvatarCount)
            ? maxAvatarCount
            : avatarUrls.length,
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
                  image: CachedNetworkImageProvider(avatarUrls[index]),
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
