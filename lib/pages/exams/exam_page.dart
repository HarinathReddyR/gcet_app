import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/exams/bloc/exam_bloc.dart';
import 'package:gcet_app/pages/exams/exam_form.dart';

class ExamPage extends StatelessWidget {
  final String rollNo;
  const ExamPage({super.key, required this.rollNo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ExamBloc>(
        create: (context) {
          return ExamBloc(
            rollNo: rollNo,
          )..add(LoadExam(rollNo: rollNo) as ExamEvent);
        },
        child: ExamForm(rollNo: rollNo),
      ),
    );
  }
}
