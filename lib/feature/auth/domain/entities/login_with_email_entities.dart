import 'package:equatable/equatable.dart';

class LoginWithEmailEntities extends Equatable {
  final String email;
  final String password;
  const LoginWithEmailEntities({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
