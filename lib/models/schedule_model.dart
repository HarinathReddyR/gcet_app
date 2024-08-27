import 'package:meta/meta.dart';

class ScheduleModel {
  late String fromTime;
  late String toTime;
  late String subName;
  late String subid;
  late String fid;
  String? facultyName;

  ScheduleModel(
      {required this.fromTime,
      required this.toTime,
      required this.subName,
      required this.subid,
      required this.fid,
      this.facultyName});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    subName = json['subName'];
    subid = json['subid'];
    fid = json['fid'];
    facultyName = json['facultyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    data['subName'] = this.subName;
    data['subid'] = this.subid;
    data['fid'] = this.fid;
    data['facultyName'] = this.facultyName;
    return data;
  }
}
