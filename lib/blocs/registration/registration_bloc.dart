import 'dart:async';

import 'package:appwrite_project/authentication/authentication_bloc.dart';
import 'package:appwrite_project/authentication/authentication_event.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../resources/user_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegistrationBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  RegistrationState get initialState => RegistrationInitial();

  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationButtonPressed) {
      yield RegistrationLoading();

      try {
        await userRepository.signup(
            email: event.email, password: event.password, name: event.name);
        authenticationBloc.add(LoggedIn());

        yield RegistrationInitial();
      } catch (e) {
        yield RegistrationFailure(error: e.toString());
      }
    }
  }
}
