class AppAssets extends Videos {
  static const String logo = "assets/logo/appLogo.jpg";
  static SvgAssets svgIcons = SvgAssets();
  static Videos videos = AppAssets();
}

abstract class Videos {
  String splash = "assets/videos/splash_video/splash.mp4";
}

class SvgAssets {
  String googleIcon = "assets/svg_icons/google_icon.svg";
  String facebookIcon = "assets/svg_icons/facebook_icons.svg";
  String appleIcon = "assets/svg_icons/ios_icons.svg";
}
