import 'package:equatable/equatable.dart';

class UserEntities extends Equatable {
  final String uid;
  final String email;

  const UserEntities({required this.uid, required this.email});

  @override
  List<Object?> get props => [uid, email];
}
