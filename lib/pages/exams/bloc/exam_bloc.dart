import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  ExamBloc({required String rollNo}) : super(ExamInitial()) {
    on<LoadExam>(
      (event, emit) async {
        emit(ExamLoading());
        try {
          emit(ExamLoaded(
            cgpa: "9.7",
          ));
        } catch (e) {
          emit(ExamError(error: e.toString(), message: 'Exam error'));
        }
      },
    );
  }
}
