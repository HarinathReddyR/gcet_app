part of "exam_bloc.dart";

abstract class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamLoaded extends ExamState {
  final String cgpa;

  const ExamLoaded({
    required this.cgpa,
  });

  @override
  List<Object> get props => [cgpa];
}

class ExamError extends ExamState {
  final String message;

  const ExamError({required this.message, required String error});

  @override
  List<Object> get props => [message];
}
