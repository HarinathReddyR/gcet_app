part of "digiL_bloc.dart";

abstract class DigitalLibraryState extends Equatable {
  const DigitalLibraryState();

  @override
  List<Object> get props => [];
}

class DigiInitial extends DigitalLibraryState {}

class DigiLoading extends DigitalLibraryState {}

class DigiLoaded extends DigitalLibraryState {
  //final String ;

  const DigiLoaded(
      //required this.cgpa,
      );

  @override
  List<Object> get props => [];
}

class DigiError extends DigitalLibraryState {
  final String message;

  const DigiError({required this.message, required String error});

  @override
  List<Object> get props => [message];
}
