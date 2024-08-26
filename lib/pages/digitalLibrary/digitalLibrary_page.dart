import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/digitalLibrary/bloc/digiL_bloc.dart';
import 'package:gcet_app/pages/digitalLibrary/digitalLibrary_form.dart';

class DigitalLibraryPage extends StatelessWidget {
  const DigitalLibraryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<DigitalLibraryBloc>(
        create: (context) {
          return DigitalLibraryBloc()..add(LoadLibrary() as DigiLibraryEvent);
        },
        child: DigitalLibraryForm(),
      ),
    );
  }
}
