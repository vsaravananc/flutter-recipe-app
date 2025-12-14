import 'package:recipe/feature/auth/domain/entities/user_entities.dart';

class UserModel extends UserEntities {
  const UserModel({
    required super.uid,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uuid'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': 1, 'uuid': uid, 'name': name, 'email': email};
  }
}
