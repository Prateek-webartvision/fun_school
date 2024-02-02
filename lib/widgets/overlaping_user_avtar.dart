import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../style/color.dart';

class OverlapingUserAvtar extends StatelessWidget {
  const OverlapingUserAvtar({
    super.key,
    required this.avtarUrls,
    this.radius = 16,
    this.maxAvtatCount = 0,
  });

  final List<String> avtarUrls;
  final double radius;
  final int maxAvtatCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (avtarUrls.length > maxAvtatCount) ? maxAvtatCount : avtarUrls.length,
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
                  image: CachedNetworkImageProvider(avtarUrls[index]),
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
