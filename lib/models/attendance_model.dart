class AttendanceModel {
  String? subject;
  int? attended;
  int? total;

  AttendanceModel({this.subject, this.attended, this.total});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    attended = json['attended'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['attended'] = this.attended;
    data['total'] = this.total;
    return data;
  }
}
