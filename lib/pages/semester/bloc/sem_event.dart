part of "sem_bloc.dart";

abstract class SemEvent {}

class LoadSem extends SemEvent {
  LoadSem();

  List<Object> get props => [];
}
