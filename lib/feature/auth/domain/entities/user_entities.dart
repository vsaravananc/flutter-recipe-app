import 'package:equatable/equatable.dart';

class UserEntities extends Equatable {
  final String uid;
  final String email;
  final String name;

  const UserEntities({required this.uid, required this.email, required this.name});

  @override
  List<Object?> get props => [uid, email,name];
}
