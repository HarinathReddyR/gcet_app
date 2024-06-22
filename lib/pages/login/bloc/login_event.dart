part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class ForgotButtonPressed extends LoginEvent {
  const ForgotButtonPressed();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ForgotButtonPressed {}';
}

class SubmitButtonPressed extends LoginEvent {
  final String username;

  const SubmitButtonPressed({required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'SubmitButtonPressed { username: $username }';
}

class BackButtonPressed extends LoginEvent {
  const BackButtonPressed();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'BackButtonPressed';
}
