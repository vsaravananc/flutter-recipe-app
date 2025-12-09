part of 'auth_ui_bloc.dart';

abstract class AuthUIEvent extends Equatable {
  const AuthUIEvent();
  @override
  List<Object> get props => [];
}

class AuthChangeLogIn extends AuthUIEvent {}

class AuthChangeSignUP extends AuthUIEvent {}
