class CoursesName {
  int? id;
  String? name;

  CoursesName({this.id, this.name});

  CoursesName.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['course_id'].toString());
    name = json['course_name'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> json = {};

    json['course_id'] = id;
    json['course_name'] = name;
    return json;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
