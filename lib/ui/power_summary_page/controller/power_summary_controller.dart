import 'package:fun_school/utils/app_utils.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../repo/power_summary_repo/power_summary_repo.dart';

class PawerSummaryController extends GetxController {
  late WebViewController webController;
  String? error;
  late ApiState apiState;
  List<PowerSummaryModel>? summarys;

  late int currentUrlIndex = 0;
  double loadingPrgress = 0;

  PawerSummaryController({required String subjectId}) {
    apiState = ApiState.loading;
    webController = WebViewController();
    webController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webController.getScrollPosition();

    _loadSummary(subjectId);
  }

  _loadUrl(String url) {
    update();
    webController.setNavigationDelegate(NavigationDelegate(
      onProgress: (progress) {
        loadingPrgress = progress / 100;
        update();
      },
    ));

    webController.loadRequest(Uri.parse(url));
  }

  loadNext() {
    if (currentUrlIndex < summarys!.length - 1) {
      currentUrlIndex++;
      _loadUrl(summarys![currentUrlIndex].uRL!);
    } else {
      AppUtils.showSnack("Page Ended");
    }
  }

  loadPre() {
    if (0 < currentUrlIndex) {
      currentUrlIndex--;
      _loadUrl(summarys![currentUrlIndex].uRL!);
    } else {
      AppUtils.showSnack("Page Ended");
    }
  }

  _loadSummary(String subjectId) async {
    await PowerSummaryRepository.getSummary(subjectId).then((value) {
      summarys = value;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });

    if (summarys != null && summarys!.isNotEmpty) {
      currentUrlIndex = 0;
      _loadUrl(summarys![currentUrlIndex].uRL!);
    }

    update();
  }
}
