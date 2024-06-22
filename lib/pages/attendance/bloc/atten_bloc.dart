import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/api/api_connection.dart';
import 'package:gcet_app/models/attendance_model.dart';

part 'atten_event.dart';
part 'atten_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitialState()) {
    on<FetchAttendance>(
      (event, emit) async {
        emit(AttendanceLoadingState());
        try {
          final List<AttendanceModel> attendance =
              await getAttendance("21R11A05K0");
          emit(AttendanceLoadedState(attendance));
        } catch (e) {
          emit(AttendanceErrorState(error: e.toString()));
        }
      },
    );
  }
  //AttendanceBloc() : super(AttendanceInitialState());
  //@override
  // Stream<AttendanceState> mapEventToState(
  //   AttendanceEvent event,
  // ) async* {
  //   if (event is FetchAttendance) {
  //     yield AttendanceLoadingState();
  //     try {
  //       final List<AttendanceModel> attendance = await getAttendance("21");
  //       yield AttendanceLoadedState(attendance);
  //     } catch (e) {
  //       yield AttendanceErrorState(error: e.toString());
  //     }
  //   }
  // }
}
