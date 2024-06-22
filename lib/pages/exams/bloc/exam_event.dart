part of "exam_bloc.dart";

abstract class ExamEvent {}

class LoadExam extends ExamEvent {
  final String rollNo;
  LoadExam({required this.rollNo});

  List<Object> get props => [rollNo];
}
