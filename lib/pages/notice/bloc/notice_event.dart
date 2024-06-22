part of "notice_bloc.dart";

abstract class NoticeEvent {}

class LoadNotice extends NoticeEvent {
  LoadNotice();

  List<Object> get props => [];
}
