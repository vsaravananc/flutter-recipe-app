import 'package:recipe/feature/auth/domain/entities/user_entities.dart';

class UserModel extends UserEntities {
  const UserModel({required super.uid, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(uid: json['uuid'], email: json['email']);
  }
}
