import 'package:citycloud_school/uitls/app_utils.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../repo/pawor_summary_repo/pawor_summary_repo.dart';

class PaworSummaryController extends GetxController {
  late WebViewController webController;
  String? error;
  late ApiState apiState;
  List<PaworSummaryModel>? summarys;

  late int currentUrlIndex;
  double loadingPrgress = 0;

  PaworSummaryController({required String subjectId}) {
    apiState = ApiState.loading;
    webController = WebViewController();
    webController.setJavaScriptMode(JavaScriptMode.unrestricted);

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
      AppUtils.showSnack("page Ended");
    }
  }

  loadPre() {
    if (0 < currentUrlIndex) {
      currentUrlIndex--;
      _loadUrl(summarys![currentUrlIndex].uRL!);
    } else {
      AppUtils.showSnack("page Ended");
    }
  }

  _loadSummary(String subjectId) async {
    await PaworSummaryRepository.getSummary(subjectId).then((value) {
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
