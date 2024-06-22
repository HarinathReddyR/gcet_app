import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/attendance/bloc/atten_bloc.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gcet attendance"),
      ),
      body: BlocProvider(
        create: (context) =>
            AttendanceBloc()..add(const FetchAttendance("21R11A05k0")),
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state is AttendanceLoadedState) {
              return ListView.builder(
                itemCount: state.atten.length,
                itemBuilder: (context, index) {
                  final attendance = state.atten[index];
                  return ListTile(
                    title: Text(attendance.subject.toString()),
                    subtitle: Text(
                        'Attended: ${attendance.attended} / Total: ${attendance.total}'),
                  );
                },
              );
            }
            if (state is AttendanceLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(child: Text("An error occured"));
          },
        ),
      ),
    );
  }
}
