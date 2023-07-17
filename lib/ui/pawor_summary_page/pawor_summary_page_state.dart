import 'package:flutter/material.dart';

import 'controller/pawor_summary_controller.dart';
import 'pawor_summary_page.dart';

abstract class PaworSummaryPageState extends State<PaworSummaryPage> {
  late PaworSummaryController paworSummaryController;
  @override
  void initState() {
    paworSummaryController = PaworSummaryController(subjectId: widget.subjectId);
    super.initState();
  }
}
