import 'dart:async';

import 'package:appwrite_project/authentication/authentication_event.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:appwrite_project/authentication/authentication_bloc.dart';
import 'package:bloc/bloc.dart';

import '../../resources/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        await userRepository.createUserSession(event.email, event.password);
        authenticationBloc.add(LoggedIn());
        
        yield LoginInitial();
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }
  }
}
