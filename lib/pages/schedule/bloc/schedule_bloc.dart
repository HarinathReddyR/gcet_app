import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/api/api_connection.dart';
import 'package:gcet_app/models/schedule_model.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc({required String rollNo}) : super(ScheduleInitial()) {
    on<LoadSchedule>(
      (event, emit) async {
        emit(ScheduleLoading());
        try {
          final List<ScheduleModel> schedule =
              await getSchedule(rollNo, event.selectedDate);
          if (schedule.isEmpty) {
            emit(ScheduleEmpty());
          } else
            emit(ScheduleLoaded(periods: schedule));
        } catch (e) {
          emit(ScheduleError(error: e.toString(), message: 'schedule error'));
        }
      },
    );
  }
}
