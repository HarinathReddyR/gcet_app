import 'package:meta/meta.dart';

class AttendanceModel {
  String subject;
  int attended;
  int total;
  double percentage;

  AttendanceModel({
    required this.subject,
    required this.attended,
    required this.total,
  }) : percentage = (attended / total) * 100;

  // Factory constructor for creating a new instance from a map
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      subject: json['subject'],
      attended: json['attended'],
      total: json['total'],
    );
  }

  // Method for converting instance data to a map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['attended'] = attended;
    data['total'] = total;
    data['percentage'] = percentage;
    return data;
  }
}

class TotalAttendance {
  late int total;
  late int attended;

  TotalAttendance({required this.total, required this.attended});

  TotalAttendance.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    attended = json['attended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['attended'] = this.attended;
    return data;
  }
}
