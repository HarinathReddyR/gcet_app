part of "profile_bloc.dart";

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String batch;
  final String branch;
  final String section;

  const ProfileLoaded({
    required this.name,
    required this.batch,
    required this.branch,
    required this.section,
  });

  @override
  List<Object> get props => [name, batch, branch, section];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message, required String error});

  @override
  List<Object> get props => [message];
}
