part of 'atten_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
  List<Object?> get props => [];
}

class FetchAttendance extends AttendanceEvent {
  final String username; // Add username as an argument

  const FetchAttendance(this.username); // Update constructor to accept username

  @override
  List<Object?> get props => [username]; // Include username in props list

  String get getUsername => username; //method to get usename from this
}
