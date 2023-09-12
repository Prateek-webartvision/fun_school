import 'package:flutter/widgets.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/const.dart';

class PieColorBox extends StatelessWidget {
  const PieColorBox({
    super.key,
    required this.boxColor,
    required this.text,
  });
  final Color boxColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        7.width,
        Text(
          text,
          style: AppTextStyle.text12W400,
        ),
      ],
    );
  }
}
