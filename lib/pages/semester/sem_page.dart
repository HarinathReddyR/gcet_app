import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/semester/bloc/sem_bloc.dart';
import 'package:gcet_app/pages/semester/sem_form.dart';

class SemPage extends StatelessWidget {
  // final String rollNo;
  const SemPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SemBloc>(
        create: (context) {
          return SemBloc()..add(LoadSem() as SemEvent);
        },
        child: SemForm(),
      ),
    );
  }
}
