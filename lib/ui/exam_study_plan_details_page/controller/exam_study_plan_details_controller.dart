import 'package:get/state_manager.dart';

import '../../../models/exams/exam_study_plan_models/exam_study_plan_model.dart';
import '../../../models/exams/exam_study_plan_models/time_table_model.dart';
import 'week_day_selector_controller.dart';

class ExamStudyPlanDetailsController extends GetxController {
  final ExamStudyPlanModel studyPlan;
  late Set<String> _weekSet;
  String? selectedWeek;

  List<TimeTableModel> timeTable = [];

  late WeekDaySelectorController weekDaySelectorController;
  List<int> weekDays = [1, 2, 3, 4, 5, 6, 7];

  ExamStudyPlanDetailsController({required this.studyPlan}) {
    weekDaySelectorController = WeekDaySelectorController();

    _weekSet = studyPlan.examStudyPlanTimetable?.reversed.map((e) => e.week!).toSet() ?? {};
    if (_weekSet.isNotEmpty) {
      selectedWeek = _weekSet.first;
    }
    _filterData();
  }

  List<String> get weekSet => _weekSet.toList();

  set setWeek(String week) {
    selectedWeek = week;
    _filterData();
    update();
  }

  onDayChange() {
    _filterData();
    // update();
  }

  _filterData() {
    final temp = studyPlan.examStudyPlanTimetable?.where(
      (element) => element.week == selectedWeek && int.parse(element.day.toString()) == (weekDaySelectorController.currentIndex + 1),
    );
    timeTable = temp?.toList() ?? [];
    update();
  }
}
