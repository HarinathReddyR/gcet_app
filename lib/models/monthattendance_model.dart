class MonthAttendanceModel {
  DateTime date; // Changed from int to DateTime
  int attended;
  int total;
  double percentage;
  bool isHoliday;

  MonthAttendanceModel({
    required this.date,
    required this.attended,
    required this.total,
    required this.isHoliday,
  }) : percentage = (total > 0) ? (attended / total) * 100 : 0;

  factory MonthAttendanceModel.fromJson(Map<String, dynamic> json) {
    return MonthAttendanceModel(
      date: DateTime.parse(json['date']), // Parse date from string
      attended: json['attended'],
      total: json['total'],
      isHoliday: json['isHoliday'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(), // Convert date to string
      'attended': attended,
      'total': total,
      'isHoliday': isHoliday,
      'percentage': percentage,
    };
  }
}
