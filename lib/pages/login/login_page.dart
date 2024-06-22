import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:gcet_app/bloc/auth_bloc.dart';
import 'package:gcet_app/db/user_repository.dart';
import 'package:gcet_app/pages/login/bloc/login_bloc.dart';
import 'package:gcet_app/pages/login/login_form.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  const LoginPage({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}