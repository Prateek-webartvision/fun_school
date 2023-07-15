import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/tips/tips_repo.dart';

class HomePageTipController extends GetxController {
  String? error;
  ApiState? apiState;
  List<TipsModel>? tips;

  HomePageTipController() {
    apiState = ApiState.loading;
    _loadTips();
  }

  void _loadTips() async {
    await TipsRepository.getTips().then((value) {
      tips = value;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });
    update();
  }
}
