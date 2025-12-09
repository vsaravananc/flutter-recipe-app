import 'package:recipe/feature/auth/domain/entities/login_with_email_entities.dart';

class LoginWithEmailModel {
  final String email;
  final String password;

  LoginWithEmailModel({required this.email, required this.password});

  factory LoginWithEmailModel.fromJson(Map<String, dynamic> json) {
    return LoginWithEmailModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  factory LoginWithEmailModel.fromEntity(LoginWithEmailEntities entities) {
    return LoginWithEmailModel(
      email: entities.email,
      password: entities.password,
    );
  }
}
