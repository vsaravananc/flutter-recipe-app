part of 'auth_ui_bloc.dart';

abstract class AuthUIState extends Equatable {
  const AuthUIState();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthUIState {}

class AuthSignUp extends AuthUIState {}
