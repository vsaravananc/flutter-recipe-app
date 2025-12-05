import 'package:recipe/feature/auth/domain/entities/login_with_email_entities.dart';

class LoginWithEmailModel extends LoginWithEmailEntities {
  const LoginWithEmailModel({required super.email, required super.password});

  factory LoginWithEmailModel.fromJson(Map<String, dynamic> json) {
    return LoginWithEmailModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
