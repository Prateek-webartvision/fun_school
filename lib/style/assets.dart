class AppAssets extends Videos with SvgAssets {
  // static const String logo = "assets/logo/appLogo.jpg";
  static const String logo = "assets/logo/appLogo.png";
  // static SvgAssets svgIcons = SvgAssets();
  AppAssets();

  static SvgAssets get svg => AppAssets();

  static Videos videos = AppAssets();
}

abstract class Videos {
  String splash = "assets/videos/splash_video/splash.mp4";
}

mixin class SvgAssets {
  String googleIcon = "assets/svg_icons/google_icon.svg";
  String facebookIcon = "assets/svg_icons/facebook_icons.svg";
  String appleIcon = "assets/svg_icons/ios_icons.svg";

  // icon
  final String sendIcon = "assets/svg_icons/icons/send.svg";
  final String rePostIcon = "assets/svg_icons/icons/repost.svg";
  final String messageIcon = "assets/svg_icons/icons/message.svg";

  final String weChatFillIcon = "assets/svg_icons/icons/wechat-fill.svg";
  final String recordCircleIcon = "assets/svg_icons/icons/record-circle-line.svg";
  final String groupIcon = "assets/svg_icons/icons/Group.svg";
  final String groupFillIcon = "assets/svg_icons/icons/Group_fill.svg";
  final String pencilFillIcon = "assets/svg_icons/icons/pencil-fill.svg";
  final String search = "assets/svg_icons/icons/search.svg";
  final String listIcon = "assets/svg_icons/icons/list.svg";
  final String arrowRight = "assets/svg_icons/icons/arrow_right.svg";
  final String chatPollIcon = "assets/svg_icons/icons/chat-poll-line.svg";
  final String happyFaceIcon = "assets/svg_icons/icons/happy.svg";
  final String attachmentIcon = "assets/svg_icons/icons/attachment-line.svg";
  final String parentFillIcon = "assets/svg_icons/icons/parent-fill.svg";
  final String calendarlineIcon = "assets/svg_icons/icons/calendar-line.svg";
  final String openedFilderIcon = "assets/svg_icons/icons/opened.svg";
  final String zipIcon = "assets/svg_icons/icons/zip.svg";
  final String jpg = "assets/svg_icons/icons/jpg.svg";
}
