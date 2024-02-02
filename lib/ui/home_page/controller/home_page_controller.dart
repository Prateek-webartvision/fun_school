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

  reloadTips() {
    apiState = ApiState.loading;
    update();
    _loadTips();
  }

  void _loadTips() async {
    try {
      final res = await TipsRepository.getTips;
      tips = res;
      apiState = ApiState.success;
    } catch (e) {
      error = e.toString();
      apiState = ApiState.error;
    }
    update();
  }
}
