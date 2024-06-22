part of "schedule_bloc.dart";

abstract class ScheduleEvent {}

class LoadSchedule extends ScheduleEvent {
  final String rollNo;
  final DateTime selectedDate;
  LoadSchedule({required this.rollNo, required this.selectedDate});

  List<Object> get props => [rollNo];
}
