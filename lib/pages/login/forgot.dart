import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/login/bloc/login_bloc.dart';
import 'package:gcet_app/pages/login/login_form.dart';

class ForgotForm extends StatefulWidget {
  //final LoginBloc loginBloc; // Accept LoginBloc instance

  const ForgotForm({Key? key, required LoginBloc loginBloc}) : super(key: key);

  @override
  State<ForgotForm> createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  final _usernameController = TextEditingController();

  _onsubmitButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(SubmitButtonPressed(
      username: _usernameController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Forgot Password'),
      //   backgroundColor: Color.fromARGB(255, 42, 78, 119),,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Forgot Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            inputField("Username", Icons.person, _usernameController),
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
            )
          ],
        ),
      ),
    );
  }
}
