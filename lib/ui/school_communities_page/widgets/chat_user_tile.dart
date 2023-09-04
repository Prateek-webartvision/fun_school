import 'package:flutter/widgets.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class ChatUserTile extends StatelessWidget {
  const ChatUserTile({
    super.key,
    required this.onTap,
  });
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColor.softBorderColor,
              borderRadius: BorderRadius.circular(100),
              image: const DecorationImage(
                image: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          12.width,
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tutor Tina",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "10:10 PM",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  "Thanks for the resource links! They were super helpful.",
                  style: TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
