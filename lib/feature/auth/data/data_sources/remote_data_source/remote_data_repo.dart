import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/auth/data/model/login_with_email_model.dart';
import 'package:recipe/feature/auth/data/model/user_model.dart';
import 'package:recipe/feature/auth/domain/entities/sign_with_email_entities.dart';

typedef GetUser = Either<FailerHandler, SuccessHandler<UserModel>>;

abstract class RemoteDataRepo {
  Future<GetUser> loginWithEmail(LoginWithEmailModel entities);

  Future<GetUser> loginWithGoogle();

  Future<GetUser> registerWithEmail(SignWithEmailEntities entities);

  Future<GetUser> registerWithGoogle();

  Future<Map<String, dynamic>> getCurrentUser({required String uid});

  Future<void> addUser({
    required String uid,
    required String email,
    required String name,
  });

  Future<Either<bool, int>> logout();
}
