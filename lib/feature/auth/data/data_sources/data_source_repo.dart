import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/auth/data/model/login_with_email_model.dart';
import 'package:recipe/feature/auth/data/model/user_model.dart';
import 'package:recipe/feature/auth/domain/entities/sign_with_email_entities.dart';

abstract class AuthDataRepo {
  Future<Either<FailerHandler, SuccessHandler<UserModel>>> loginWithEmail(
    LoginWithEmailModel entities,
  );

  Future<Either<FailerHandler, SuccessHandler<UserModel>>> loginWithGoogle();

  Future<Either<FailerHandler, SuccessHandler<UserModel>>> registerWithEmail(
    SignWithEmailEntities entities,
  );

  Future<Either<FailerHandler, SuccessHandler<UserModel>>> registerWithGoogle();

  Future<Map<String,dynamic>> getCurrentUser({
    required String uid,
  });

  Future<void> addUser({
    required String uid,
    required String email,
    required String name,
  });

  Future<Either<bool, int>> logout();
}
