
part of 'registration_bloc.dart';
abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationFailure extends RegistrationState {
  final String error;

  const RegistrationFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RegistrationFailure { error: $error }';
}
