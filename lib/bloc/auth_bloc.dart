
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gcet_app/db/user_repository.dart';
import 'package:gcet_app/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUnintialized()) {
    on<AppStarted>(
      (event, emit) async {
        final bool hasToken = await userRepository.hasToken();

        if (hasToken) {
          emit(AuthenticationAuthenticated());
        } else {
          emit(AuthenticationUnauthenticated());
        }
      },
    );
    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());
      await userRepository.persistToken(user: event.user);
      emit(AuthenticationAuthenticated());
    });
    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      await userRepository.deleteToken(id: 0);
      emit(AuthenticationUnauthenticated());
    });
  }
}
