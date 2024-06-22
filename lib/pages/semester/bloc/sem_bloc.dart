import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sem_event.dart';
part 'sem_state.dart';

class SemBloc extends Bloc<SemEvent, SemState> {
  SemBloc() : super(SemInitial()) {
    on<LoadSem>(
      (event, emit) async {
        emit(SemLoading());
        try {
          emit(SemLoaded());
        } catch (e) {
          emit(SemError(error: e.toString(), message: 'semesterpage error'));
        }
      },
    );
  }
}
