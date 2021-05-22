import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../resources/repository.dart';
import '../../authentication/authentication_bloc.dart';
import '../../authentication/authentication_event.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserRepositoryFlutter userRepository;
  final AuthenticationBloc authenticationBloc;

  RegistrationBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(RegistrationInitial());

  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationButtonPressed) {
      yield RegistrationLoading();

      try {
        await userRepository.signup(
            event.email, event.password, event.name, event.phone);
        authenticationBloc.add(LoggedIn());

        yield RegistrationInitial();
      } catch (e) {
        yield RegistrationFailure(error: e.toString());
      }
    }
  }
}
