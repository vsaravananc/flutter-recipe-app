import 'package:dartz/dartz.dart';
import 'package:recipe/feature/auth/domain/entities/login_with_email_entities.dart';

abstract class AuthRepo {
  Future<Either<bool,int>> loginWithEmail(LoginWithEmailEntities entities);
  
  Future<void> loginWithGoogle();
  
  Future<void> registerWithEmail();
  
  Future<void> registerWithGoogle();
  
  Future<void> logout();
}

