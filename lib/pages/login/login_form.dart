// ignore_for_file: unnecessary_new

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gcet_app/pages/login/forgot.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/login/bloc/login_bloc.dart';
import 'dart:math' as math;


Widget inputField(String s, IconData ic, TextEditingController controller) {
  bool b = false;
  if (s == "Password") b = true;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5.5),
    child: SizedBox(
      height: 50,
      child: Material(
        elevation: 8,
        shadowColor: Colors.black12,
        color: Colors.transparent,
        borderRadius: BorderRadiusDirectional.circular(30),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: s,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none),
              fillColor: Colors.white10.withOpacity(0.9),
              filled: true,
              prefixIcon: Icon(ic)),
          obscureText: b,
        ),
      ),
    ),
  );
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _forgotusernameController = TextEditingController();
  final _passwordController = TextEditingController();
  _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }

  _onsubmitButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(SubmitButtonPressed(
      username: _forgotusernameController.text,
    ));
  }

  _onBackButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(const BackButtonPressed());
  }

  Widget topwidget(double screenWidth) {
    // print(screenWidth);
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          color: Colors.black26,
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7CBFCF),
              Color(0xFF5CDBCF)
            ], // Use visible colors
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginBaseState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ));
        } else if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              padding: EdgeInsets.all(16),
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: const Text(
                "New password sent to your email",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
          ));
        } else if (state is EmailNotSent) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("email not sent"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ));
        } else if (state is ForgotPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("user name not valid"),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginBaseState>(builder: (context, state) {
        final screensize = MediaQuery.of(context).size;
        if (state is LoginState) {
          return Scaffold(
              body: Stack(
            children: [
              Positioned(
                top: -screensize.width * 0.4,
                left: -screensize.width * 0.1,
                child: topwidget(screensize.width),
              ),
              Center(
                child: Container(
                  width: 400,
                  margin: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _header(context),
                      _inputField(context),
                      _forgotPassword(context),
                      Container(
                        child: state is LoginLoading
                            ? const CircularProgressIndicator()
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));
        } else if (state is ForgotPass) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                  top: -screensize.width * 0.4,
                  left: -screensize.width * 0.1,
                  child: topwidget(screensize.width),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      inputField(
                          "Username", Icons.person, _forgotusernameController),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 300,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: _onsubmitButtonPressed,
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            elevation: 8,
                            shadowColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Color.fromARGB(255, 57, 53, 163),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          _onBackButtonPressed();
                        },
                        child: const Text(
                          "Back to Login?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 53, 163),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return const Scaffold(
          body: Stack(children: [
            SizedBox(
              height: 20,
            ),
            Text(
              ' else page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ]),
        );
      }),
    );
  }

  _header(context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: Image.asset('lib/assets/logo.png'),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Login",
          style: TextStyle(fontSize: 45, fontWeight: FontWeight.w600),
        ),
        Text("Enter your credential to login", style: GoogleFonts.roboto()),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        inputField("Username", Icons.person, _usernameController),
        inputField("Password", Icons.password, _passwordController),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _onLoginButtonPressed,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 8,
            shadowColor: Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Color.fromARGB(255, 57, 53, 163),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        // print("hello");
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ForgotForm(
        //             loginBloc: BlocProvider.of<LoginBloc>(context),
        //           )),
        // );
        BlocProvider.of<LoginBloc>(context).add(const ForgotButtonPressed());
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(
          color: Color.fromARGB(255, 57, 53, 163),
        ),
      ),
    );
  }
}
