import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/main.dart';
import 'package:gcet_app/pages/exams/grades/bloc/grades_bloc.dart';
import 'package:gcet_app/pages/exams/grades/grades_form.dart';

class GradePage extends StatelessWidget {
  final String rollNo;
  final int sem;
  const GradePage({super.key, required this.rollNo, required this.sem});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<GradeBloc>(
        create: (context) {
          return GradeBloc(
            sem: sem,
            rollNo: rollNo,
          )..add(LoadGrade(sem: sem, rollNo: rollNo));
        },
        child: GradeForm(rollNo: rollNo),
      ),
    );
  }
}
