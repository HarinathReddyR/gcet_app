import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:gcet_app/models/customform_ques.dart';

part 'customform_event.dart';
part 'customform_state.dart';

class CustomFormBloc extends Bloc<CustomFormEvent, CustomFormState> {
  CustomFormBloc(List<Question> formData)
      : super(CustomFormLoaded(questions: formData)) {
    on<AddQuestionEvent>((event, emit) {
      final currentState = state;
      if (currentState is CustomFormLoaded) {
        final updatedQuestions = List<Question>.from(currentState.questions);
        updatedQuestions.add(event.newQuestion);
        emit(CustomFormLoaded(questions: updatedQuestions));
      }
    });

    on<RemoveQuestionEvent>((event, emit) {
      final currentState = state;
      if (currentState is CustomFormLoaded) {
        final updatedQuestions = List<Question>.from(currentState.questions);
        updatedQuestions.removeAt(event.index);
        emit(CustomFormLoaded(questions: updatedQuestions));
      }
    });

    on<UpdateQuestionEvent>((event, emit) {
      final currentState = state;
      if (currentState is CustomFormLoaded) {
        final updatedQuestions = List<Question>.from(currentState.questions);
        updatedQuestions[event.index].questionController.text =
            event.newQuestionText;
        emit(CustomFormLoaded(questions: updatedQuestions));
      }
    });
    on<UpdateFieldTypeEvent>((event, emit) {
      final currentState = state;
      if (currentState is CustomFormLoaded) {
        final updatedQuestions = List<Question>.from(currentState.questions);
        print(event.newFieldType);
        updatedQuestions[event.index].selectedFieldType = event.newFieldType;
        emit(CustomFormLoaded(questions: updatedQuestions));
      }
    });

    // on<UpdateFieldTypeEvent>((event, emit) {
    //   final currentState = state;
    //   if (currentState is CustomFormLoaded) {
    //     final updatedQuestions = List<Question>.from(currentState.questions);
    //     updatedQuestions[event.index].selectedFieldType = event.newFieldType;
    //     emit(CustomFormLoaded(questions: updatedQuestions));
    //   }
    // });

    on<AddFieldOptionEvent>((event, emit) {
      final currentState = state;
      if (currentState is CustomFormLoaded) {
        final updatedQuestions = List<Question>.from(currentState.questions);
        final question = updatedQuestions[event.index];
        question.fieldControllers.add(TextEditingController());
        print(question.fieldControllers.length);
        emit(CustomFormLoaded(questions: updatedQuestions));
      }
    });

    on<RemoveFieldOptionEvent>((event, emit) {
      final currentState = state;
      if (currentState is CustomFormLoaded) {
        final updatedQuestions = List<Question>.from(currentState.questions);
        final question = updatedQuestions[event.questionIndex];
        question.fieldControllers[event.optionIndex].dispose();
        question.fieldControllers.removeAt(event.optionIndex);
        emit(CustomFormLoaded(questions: updatedQuestions));
      }
    });

    on<SubmitFormEvent>((event, emit) {
      final currentState = state;
      if (currentState is CustomFormLoaded) {
        List<Map<String, dynamic>> questionsJson =
            currentState.questions.map((q) => q.toJson()).toList();
        Map<String, dynamic> formData = {
          'title': event.title,
          'descr': event.description,
          'ques': questionsJson,
        };
        emit(CustomFormSubmitted(formData: formData));
      }
    });

    on<PreviewFormEvent>((event, emit) {
      final currentState = state;
      if (currentState is CustomFormLoaded) {
        List<Map<String, dynamic>> questionsJson =
            currentState.questions.map((q) => q.toJson()).toList();
        Map<String, dynamic> formData = {
          'title': '',
          'descr': '',
          'ques': questionsJson,
        };
        emit(CustomFormPreview(formData: formData));
      }
    });
  }
}
