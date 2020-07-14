import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import './authentication_event.dart';
import './authentication_state.dart';
import '../resources/repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepositoryFlutter userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool isSignedIn = await userRepository.isSignedIn();
      if (isSignedIn) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.getSession();
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.signOut();
      yield AuthenticationUnauthenticated();
    }
  }
}
