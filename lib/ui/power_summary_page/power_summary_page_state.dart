import 'package:flutter/material.dart';

import 'controller/power_summary_controller.dart';
import 'power_summary_page.dart';

abstract class PowerSummaryPageState extends State<PawerSummaryPage> {
  late PawerSummaryController powerSummaryController;
  @override
  void initState() {
    powerSummaryController =
        PawerSummaryController(subjectId: widget.subjectId);
    super.initState();
  }
}
