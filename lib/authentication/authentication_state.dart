part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String uid;

  const Authenticated(this.uid);

  @override
  List<Object> get props => [uid];

  @override
  String toString() => 'Authenticated { uid: $uid }';
}

class Unauthenticated extends AuthenticationState {}
