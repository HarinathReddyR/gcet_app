part of 'atten_bloc.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();
  List<Object?> get props => [];
}

class AttendanceInitialState extends AttendanceState {}

class AttendanceLoadingState extends AttendanceState {}

class AttendanceLoadedState extends AttendanceState {
  final List<AttendanceModel> atten;
  final TotalAttendance totalAttendance;
  const AttendanceLoadedState(this.atten, this.totalAttendance);
  List<Object?> get props => [atten];
}

class AttendanceErrorState extends AttendanceState {
  final String error;

  const AttendanceErrorState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AttendanceFaliure { error: $error }';
}
