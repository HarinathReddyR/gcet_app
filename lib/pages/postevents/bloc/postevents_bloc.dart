import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gcet_app/models/customform_ques.dart';
// import 'package:gcet_app/pages/postevents/formgenerator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gcet_app/api/api_connection.dart';

part 'postevents_event.dart';
part 'postevents_state.dart';

class PostEventsBloc extends Bloc<PostEventsEvent, PostEventsState> {

  List<Question> questions = []; 

  PostEventsBloc() : super(PostEventsInitial()) {
    on<PostEvent>(_onPostEvent);
    on<SaveFormEvent>(_onSaveFormEvent);
  }

  void _onSaveFormEvent(SaveFormEvent event, Emitter<PostEventsState> emit) {
    questions = event.questions; // Update the stored questions
    emit(FormSavedState(questions: questions)); // Emit a state to notify that form is saved
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
        event.reg,
        event.ques
      );
      emit(PostEventsSuccess());
    } catch (e) {
      emit(PostEventsFailure(error: e.toString()));
    }
  }
}
