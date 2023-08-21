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
}
