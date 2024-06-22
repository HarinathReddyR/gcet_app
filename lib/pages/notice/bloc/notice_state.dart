part of "notice_bloc.dart";

abstract class NoticeState extends Equatable {
  const NoticeState();

  @override
  List<Object> get props => [];
}

class NoticeInitial extends NoticeState {}

class NoticeLoading extends NoticeState {}

class NoticeLoaded extends NoticeState {
  //final String ;

  const NoticeLoaded(
      //required this.cgpa,
      );

  @override
  List<Object> get props => [];
}

class NoticeError extends NoticeState {
  final String message;

  const NoticeError({required this.message, required String error});

  @override
  List<Object> get props => [message];
}
