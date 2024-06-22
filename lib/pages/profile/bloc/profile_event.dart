part of "profile_bloc.dart";

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String rollNo;
  LoadProfile({required this.rollNo});

  List<Object> get props => [rollNo];
}
