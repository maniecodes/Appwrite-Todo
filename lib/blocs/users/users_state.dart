import 'package:appwrite_project/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {}

class UsersLoadSuccess extends UsersState {
  final User user;

  const UsersLoadSuccess(this.user);

  List<Object> get props => [user];

  @override
  String toString() => "UserLoadSuccess {user: $user}";
}

class UsersFailure extends UsersState {
  final String error;

  const UsersFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UsersFailure { error: $error }';
}
