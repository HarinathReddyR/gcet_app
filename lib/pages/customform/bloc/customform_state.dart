part of 'customform_bloc.dart';

abstract class CustomFormState extends Equatable {
  const CustomFormState();

  @override
  List<Object> get props => [];
}

class CustomFormInitial extends CustomFormState {}

class CustomFormLoaded extends CustomFormState {
  final List<Question> questions;

  const CustomFormLoaded(
      {this.questions = const []});

  @override
  List<Object> get props => [questions];
}

class CustomFormPreview extends CustomFormState {
  final Map<String, dynamic> formData;

  const CustomFormPreview({required this.formData});

  @override
  List<Object> get props => [formData];
}

class CustomFormSubmitted extends CustomFormState {
  final Map<String, dynamic> formData;

  const CustomFormSubmitted({required this.formData});

  @override
  List<Object> get props => [formData];
}
