class StudentPresent {
  late String name;
  late String rollNo;
  late bool isPresent;

  StudentPresent(
      {required this.name, required this.rollNo, required this.isPresent});
// required this.name
  StudentPresent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rollNo = json['rollNo'];
    isPresent = json['isPresent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rollNo'] = this.rollNo;
    data['isPresent'] = this.isPresent;
    return data;
  }
}
