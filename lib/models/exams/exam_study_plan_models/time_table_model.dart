class TimeTableModel {
  int? timetableId;
  String? studyPlanId;
  String? week;
  String? day;
  String? subject;
  String? period;
  int? dateAdded;

  TimeTableModel.fromJson(Map<String, dynamic> json) {
    timetableId = int.tryParse(json['timetable_id']);
    studyPlanId = json['study_plan_id'];
    week = json['week'];
    day = json['day'];
    subject = json['subject'];
    period = json['period'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};
    json['timetable_id'] = timetableId;
    json['study_plan_id'] = studyPlanId;
    json['week'] = week;
    json['day'] = day;
    json['subject'] = subject;
    json['period'] = period;
    json['date_added'] = dateAdded;
    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
