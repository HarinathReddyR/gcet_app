class ScheduleModel {
  late String fromTime;
  late String toTime;
  late String subName;
  String? facultyName;

  ScheduleModel(
      {required this.fromTime,
      required this.toTime,
      required this.subName,
      this.facultyName});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    subName = json['subName'];
    facultyName = json['facultyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    data['subName'] = this.subName;
    data['facultyName'] = this.facultyName;
    return data;
  }
}
