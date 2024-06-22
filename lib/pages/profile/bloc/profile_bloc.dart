import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required String rollNo}) : super(ProfileInitial()) {
    on<LoadProfile>(
      (event, emit) async {
        emit(ProfileLoading());
        try {
          emit(ProfileLoaded(
              name: "Ramidi Harinath reddy",
              batch: "2021",
              branch: "cse",
              section: "D"));
        } catch (e) {
          emit(ProfileError(error: e.toString(), message: 'Profile error'));
        }
      },
    );
  }
}
