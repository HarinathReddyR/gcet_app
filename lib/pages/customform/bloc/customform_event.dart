part of 'customform_bloc.dart';

abstract class CustomFormEvent extends Equatable {
  const CustomFormEvent();

  @override
  List<Object> get props => [];
}

class AddQuestionEvent extends CustomFormEvent {
  final Question newQuestion;

  const AddQuestionEvent(this.newQuestion);

  @override
  List<Object> get props => [newQuestion];
}

class RemoveQuestionEvent extends CustomFormEvent {
  final int index;

  const RemoveQuestionEvent(this.index);

  @override
  List<Object> get props => [index];
}

class AddFieldOptionEvent extends CustomFormEvent {
  final int index;

  const AddFieldOptionEvent(this.index);

  @override
  List<Object> get props => [index];
}

class RemoveFieldOptionEvent extends CustomFormEvent {
  final int questionIndex;
  final int optionIndex;

  const RemoveFieldOptionEvent(this.questionIndex, this.optionIndex);

  @override
  List<Object> get props => [questionIndex, optionIndex];
}

class SubmitFormEvent extends CustomFormEvent {
  final String title;
  final String description;

  const SubmitFormEvent({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class PreviewFormEvent extends CustomFormEvent {}

class UpdateQuestionEvent extends CustomFormEvent {
  final int index;
  final String newQuestionText;

  const UpdateQuestionEvent({required this.index, required this.newQuestionText});

  @override
  List<Object> get props => [index, newQuestionText];
}

class UpdateFieldTypeEvent extends CustomFormEvent {
  final int index;
  final String newFieldType;

  const UpdateFieldTypeEvent({required this.index, required this.newFieldType});

  @override
  List<Object> get props => [index, newFieldType];
}
