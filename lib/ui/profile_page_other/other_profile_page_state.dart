import 'package:flutter/material.dart';

import 'controller/other_profile_controller.dart';
import 'other_profile_page.dart';

abstract class OtherProfilePageState extends State<OtherProfilePage> with TickerProviderStateMixin {
  late TabController tabController;
  late OtherProfileController otherProfileController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    otherProfileController = OtherProfileController(widget.userId);
    super.initState();
  }
}
