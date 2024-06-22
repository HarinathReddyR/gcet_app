import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gcet_app/api/api_connection.dart';

part 'postevents_event.dart';
part 'postevents_state.dart';

class PostEventsBloc extends Bloc<PostEventsEvent, PostEventsState> {
  PostEventsBloc() : super(PostEventsInitial()) {
    on<PostEvent>(_onPostEvent);
  }

  Future<void> _onPostEvent(PostEvent event, Emitter<PostEventsState> emit) async {
    emit(PostEventsLoading());
    try {
      await postEvent(
        event.title,
        event.description,
        event.date,
        event.venue,
        event.imageFileList,
      );
      emit(PostEventsSuccess());
    } catch (e) {
      emit(PostEventsFailure(error: e.toString()));
    }
  }
}
