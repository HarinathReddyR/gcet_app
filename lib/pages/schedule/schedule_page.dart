import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/schedule/bloc/schedule_bloc.dart';
import 'package:gcet_app/pages/schedule/schedule_form.dart';

class SchedulePage extends StatelessWidget {
  final String rollNo;
  const SchedulePage({super.key, required this.rollNo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ScheduleBloc>(
        create: (context) {
          //ScheduleBlocBloc()..add(const getSchdule("21R11A05k0")),
          return ScheduleBloc(
            rollNo: rollNo,
          )..add(LoadSchedule(rollNo: rollNo, selectedDate: DateTime.now())
              as ScheduleEvent);
        },
        child: ScheduleForm(rollNo: rollNo),
      ),
    );
  }
}
