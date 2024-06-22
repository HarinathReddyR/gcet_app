import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  NoticeBloc() : super(NoticeInitial()) {
    on<LoadNotice>(
      (event, emit) async {
        emit(NoticeLoading());
        try {
          emit(NoticeLoaded());
        } catch (e) {
          emit(NoticeError(error: e.toString(), message: 'notice error'));
        }
      },
    );
  }
}
