part of 'postevents_bloc.dart';

abstract class PostEventsState extends Equatable {
  const PostEventsState();

  @override
  List<Object> get props => [];
}

class PostEventsInitial extends PostEventsState {}

class PostEventsLoading extends PostEventsState {}

class PostEventsSuccess extends PostEventsState {}

class PostEventsFailure extends PostEventsState {
  final String error;

  const PostEventsFailure({required this.error});

  @override
  List<Object> get props => [error];
}
