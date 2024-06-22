part of 'login_bloc.dart';

abstract class LoginBaseState extends Equatable {
  const LoginBaseState();

  @override
  List<Object> get props => [];
}

class LoginState extends LoginBaseState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class ForgotPass extends LoginBaseState {
  const ForgotPass();
}

class LoginLoading extends LoginState {}

class ForgotInitial extends ForgotPass {}

class ForgotPasswordSuccess extends ForgotPass {
  final user;
  final email;

  const ForgotPasswordSuccess({
    required this.user,
    required this.email,
  });

  @override
  List<Object> get props => [user, email];
}

class NotValidUser extends ForgotPass {}

class EmailNotSent extends ForgotPass {}

class ForgotPasswordFailure extends ForgotPass {
  final String error;

  const ForgotPasswordFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' ForgotPasswordFailure { error: $error }';
}

class LoginFaliure extends LoginState {
  final String error;

  const LoginFaliure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' LoginFaliure { error: $error }';
}
