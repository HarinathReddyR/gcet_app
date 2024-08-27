import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'digiL_event.dart';
part 'digiL_state.dart';

class DigitalLibraryBloc extends Bloc<DigiLibraryEvent, DigitalLibraryState> {
  DigitalLibraryBloc() : super(DigiInitial()) {
    on<LoadLibrary>(
      (event, emit) async {
        emit(DigiLoading());
        try {
          emit(DigiLoaded());
        } catch (e) {
          emit(DigiError(error: e.toString(), message: 'digi error'));
        }
      },
    );
  }
}
