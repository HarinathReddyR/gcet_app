part of "grades_bloc.dart";

abstract class GradeState extends Equatable {
  const GradeState();

  @override
  List<Object> get props => [];
}

class GradeInitial extends GradeState {}

class GradeLoading extends GradeState {}

class GradeLoaded extends GradeState {
  final List<List<String>> memo;

  const GradeLoaded({
    required this.memo,
  });

  @override
  List<Object> get props => [memo];
}

class GradeError extends GradeState {
  final String message;

  const GradeError({required this.message, required String error});

  @override
  List<Object> get props => [message];
}
