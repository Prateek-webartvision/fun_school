import 'package:fun_school/repo/study_plan_repo/study_plan_repo.dart';
import 'package:fun_school/ui/study_page/model/study_plan_model.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';

class MyStudyPlanController extends GetxController {
  List<StudyPlanModel>? studyPlans;
  ApiState apiState = ApiState.loading;
  String? error;

  MyStudyPlanController() {
    _init();
  }

  _init() async {
    await _loadData();
  }

  _loadData() async {
    apiState = ApiState.loading;
    // await StudyPlanRepository.getStudyPlans().then((value) {
    //   studyPlans = value;
    //   apiState = ApiState.success;
    // }).onError((error, stackTrace) {
    //   this.error = error.toString();
    //   apiState = ApiState.error;
    // });
    loadData();
    update();
  }

  loadData() async {
    await StudyPlanRepository.getStudyPlans().then((value) {
      studyPlans = value;
      apiState = ApiState.success;
    }).onError((error, stackTrace) {
      this.error = error.toString();
      apiState = ApiState.error;
    });
    update();
  }
}
