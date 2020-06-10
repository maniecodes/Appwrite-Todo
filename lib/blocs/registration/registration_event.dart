part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationButtonPressed extends RegistrationEvent {
  final String email;
  final String password;
  final String name;

  const RegistrationButtonPressed({
    @required this.email,
    @required this.password,
    @required this.name
  });

  @override
  List<Object> get props => [email, password, name];

  @override
  String toString() =>
      'RegistrationButtonPressed { username: $email, password: $password, name: $name }';
}
