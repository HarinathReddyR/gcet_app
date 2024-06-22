part of "grades_bloc.dart";

abstract class GradeEvent {}

class LoadGrade extends GradeEvent {
  final int sem;
  final String rollNo;
  LoadGrade({required this.sem, required this.rollNo});

  List<Object> get props => [rollNo];
}
