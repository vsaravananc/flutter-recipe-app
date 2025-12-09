import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/auth/domain/entities/login_with_email_entities.dart';
import 'package:recipe/feature/auth/domain/entities/sign_with_email_entities.dart';
import 'package:recipe/feature/auth/domain/entities/user_entities.dart';

abstract class AuthRepo {
  Future<Either<FailerHandler, SuccessHandler<UserEntities>>> loginWithEmail(
    LoginWithEmailEntities entities,
  );

  Future<Either<FailerHandler, SuccessHandler<UserEntities>>> loginWithGoogle();

  Future<Either<FailerHandler, SuccessHandler<UserEntities>>> registerWithEmail(
    SignWithEmailEntities entities,
  );

  Future<Either<FailerHandler, SuccessHandler<UserEntities>>> registerWithGoogle();

  Future<Either<bool, int>> logout();
}
