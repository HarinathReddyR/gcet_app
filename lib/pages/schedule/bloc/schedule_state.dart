part of "schedule_bloc.dart";

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleEmpty extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  //final DateTime date;
  final List<ScheduleModel> periods;

  const ScheduleLoaded({
    //required this.date,
    required this.periods,
  });

  @override
  List<Object> get props => [periods];
}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError({required this.message, required String error});

  @override
  List<Object> get props => [message];
}
