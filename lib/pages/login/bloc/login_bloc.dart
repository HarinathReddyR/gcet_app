import 'package:bloc/bloc.dart';
import 'package:gcet_app/api/api_connection.dart';
import 'package:gcet_app/models/forgotpass.dart';
import '../../../bloc/auth_bloc.dart';
import 'package:gcet_app/db/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginBaseState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>(
      (event, emit) async {
        emit(LoginInitial());

        try {
          final user = await userRepository.authenticate(
            username: event.username,
            password: event.password,
          );

          authenticationBloc.add(LoggedIn(user: user));
          emit(LoginInitial());
        } catch (error) {
          emit(LoginFaliure(error: error.toString()));
        }
      },
    );
    on<SubmitButtonPressed>(
      (event, emit) async {
        emit(ForgotInitial());

        try {
          final Forgot check = await userRepository.forgotPassword(
            username: event.username,
          );
          // print(check);

          if (check.user && check.email) {
            emit(ForgotPasswordSuccess(user: check.user, email: check.email));
          } else if (check.user) {
            emit(EmailNotSent());
          } else {
            emit(const ForgotPasswordFailure(error: 'User does not exist'));
          }

          emit(ForgotInitial());
        } catch (error) {
          emit(LoginFaliure(error: error.toString()));
        }
      },
    );
    on<ForgotButtonPressed>(
      (event, emit) async {
        try {
          emit(ForgotInitial());
        } catch (error) {
          emit(LoginFaliure(error: error.toString()));
        }
      },
    );
    on<BackButtonPressed>(
      (event, emit) async {
        try {
          emit(LoginInitial());
        } catch (error) {
          emit(LoginFaliure(error: error.toString()));
        }
      },
    );
  }
}
