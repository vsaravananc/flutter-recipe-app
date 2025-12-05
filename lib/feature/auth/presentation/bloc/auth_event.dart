part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthLoginWithEmail extends AuthEvent {
  final LoginWithEmailEntities loginWithEmailEntites;
  const AuthLoginWithEmail(this.loginWithEmailEntites);
}

class AuthLoginWithGoogle extends AuthEvent {}

class AuthLogout extends AuthEvent {}

class AuthRegisterWithEmail extends AuthEvent {}

class AuthRegisterWithGoogle extends AuthEvent {}