import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/auth/data/data_sources/data_source_repo.dart';
import 'package:recipe/feature/auth/data/model/login_with_email_model.dart';
import 'package:recipe/feature/auth/domain/entities/login_with_email_entities.dart';
import 'package:recipe/feature/auth/domain/entities/sign_with_email_entities.dart';
import 'package:recipe/feature/auth/domain/entities/user_entities.dart';
import 'package:recipe/feature/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataRepo dataRepo;
  AuthRepoImpl({required this.dataRepo});
  @override
  Future<Either<FailerHandler, SuccessHandler<UserEntities>>> loginWithEmail(
    LoginWithEmailEntities entities,
  ) async {
    return await dataRepo.loginWithEmail(
      LoginWithEmailModel.fromEntity(entities),
    );
  }

  @override
  Future<Either<FailerHandler, SuccessHandler<UserEntities>>> loginWithGoogle() async{
    return await dataRepo.loginWithGoogle();
  }

  @override
  Future<Either<bool, int>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<Either<FailerHandler, SuccessHandler<UserEntities>>> registerWithEmail(
    SignWithEmailEntities entities,
  ) async {
    return await dataRepo.registerWithEmail(entities);
  }

  @override
  Future<Either<FailerHandler, SuccessHandler<UserEntities>>> registerWithGoogle() async{
   return await dataRepo.registerWithGoogle();
  }
}
