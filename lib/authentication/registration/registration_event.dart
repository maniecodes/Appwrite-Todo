part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegistrationEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegistrationEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class RegistrationSubmitted extends RegistrationEvent {
  final String email;
  final String password;
  // final String firstName;

  const RegistrationSubmitted({
    @required this.email,
    @required this.password,
    // @required this.firstName
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password,}';
  }
}
