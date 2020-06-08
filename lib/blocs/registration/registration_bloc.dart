import 'dart:async';
import 'package:appwrite_project/utils/Validators.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../resources/user_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserRepository _userRepository;

  RegistrationBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegistrationState get initialState => RegistrationState.empty();

  @override
  Stream<Transition<RegistrationEvent, RegistrationState>> transformEvents(
    Stream<RegistrationEvent> events,
    TransitionFunction<RegistrationEvent, RegistrationState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is RegistrationSubmitted) {
      yield* _mapFormSubmittedToState(event.email, event.password, event.name);
    }
  }

  Stream<RegistrationState> _mapEmailChangedToState(String email) async* {
    if (email.length > 0) {
      yield state.update(
        isEmailValid: Validators.isValidEmail(email),
      );
    }
  }

  Stream<RegistrationState> _mapPasswordChangedToState(String password) async* {
    if (password.length > 0) {
      yield state.update(
        isPasswordValid: Validators.isValidPassword(password),
      );
    }
  }

  Stream<RegistrationState> _mapFormSubmittedToState(
    String email,
    String password,
    String name,
  ) async* {
    yield RegistrationState.loading();
    try {
      await _userRepository.signup(
          email: email, password: password, name: name);
      yield RegistrationState.success();
    } catch (e) {
      print('registration bloc');
      print(e.toString());
      yield RegistrationState.failure(e.toString());
    }
  }
}
