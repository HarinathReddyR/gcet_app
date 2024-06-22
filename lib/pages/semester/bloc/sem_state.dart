part of "sem_bloc.dart";

abstract class SemState extends Equatable {
  const SemState();

  @override
  List<Object> get props => [];
}

class SemInitial extends SemState {}

class SemLoading extends SemState {}

class SemLoaded extends SemState {
  //final String ;

  const SemLoaded(
      //required this.cgpa,
      );

  @override
  List<Object> get props => [];
}

class SemError extends SemState {
  final String message;

  const SemError({required this.message, required String error});

  @override
  List<Object> get props => [message];
}
