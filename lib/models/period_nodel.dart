class PeriodModel {
  final String subjectName;
  final bool isPresent;
  final String facultyName;

  PeriodModel({
    required this.subjectName,
    required this.isPresent,
    required this.facultyName,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) {
    return PeriodModel(
      subjectName: json['subjectName'],
      isPresent: json['isPresent'],
      facultyName: json['facultyName'],
    );
  }
}
