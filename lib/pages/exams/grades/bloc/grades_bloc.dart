import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'grades_event.dart';
part 'grades_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  GradeBloc({required String rollNo, required int sem})
      : super(GradeInitial()) {
    on<LoadGrade>(
      (event, emit) async {
        emit(GradeLoading());
        try {
          emit(const GradeLoaded(
            memo: [
              ["iot", "A"],
              ["Ds", "O"]
            ],
          ));
        } catch (e) {
          emit(GradeError(error: e.toString(), message: 'grade error'));
        }
      },
    );
  }
}
