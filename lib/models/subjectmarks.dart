class Subject {
  final String name;
  final String score;
  final List<Assignment> assignments;

  Subject({required this.name, required this.score, required this.assignments});
}

class Assignment {
  final String name;
  final String marks;

  Assignment({required this.name, required this.marks});
}
