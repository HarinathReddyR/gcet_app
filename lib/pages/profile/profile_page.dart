import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/profile/bloc/profile_bloc.dart';
import 'package:gcet_app/pages/profile/profile_form.dart';

class ProfilePage extends StatelessWidget {
  final String rollNo;
  const ProfilePage({super.key, required this.rollNo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ProfileBloc>(
        create: (context) {
          //ScheduleBlocBloc()..add(const getSchdule("21R11A05k0")),
          return ProfileBloc(
            rollNo: rollNo,
          )..add(LoadProfile(rollNo: rollNo));
        },
        child: ProfileForm(rollNo: rollNo),
      ),
    );
  }
}
