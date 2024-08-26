part of 'postevents_bloc.dart';

abstract class PostEventsEvent extends Equatable {
  const PostEventsEvent();

  @override
  List<Object> get props => [];
}

class PostEvent extends PostEventsEvent {
  final String title;
  final String description;
  final String date;
  final String venue;
  final List<XFile> imageFileList;
  final bool reg;
  final List<Question> ques;

  const PostEvent(
      {required this.title,
      required this.description,
      required this.date,
      required this.venue,
      required this.imageFileList,
      required this.reg,
      required this.ques});

  @override
  List<Object> get props => [title, description, date, venue, imageFileList];
}

class SaveFormEvent extends PostEventsEvent {
  final List<Question> questions;

  const SaveFormEvent({required this.questions});

  @override
  List<Object> get props => [questions];
}
