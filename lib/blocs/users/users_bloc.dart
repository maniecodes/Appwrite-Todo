import 'package:appwrite_project/blocs/users/users_event.dart';
import 'package:appwrite_project/blocs/users/users_state.dart';
import 'package:appwrite_project/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository userRepository;

  UsersBloc({@required this.userRepository});

  @override
  UsersState get initialState => UsersLoading();

  @override 
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is UsersLoaded) {

    }
  }

}
