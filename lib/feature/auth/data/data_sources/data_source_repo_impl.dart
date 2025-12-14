import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/auth/data/data_sources/data_source_repo.dart';
import 'package:recipe/feature/auth/data/data_sources/local_data_source/local_data_repo.dart';
import 'package:recipe/feature/auth/data/data_sources/remote_data_source/remote_data_repo.dart';
import 'package:recipe/feature/auth/data/model/login_with_email_model.dart';
import 'package:recipe/feature/auth/data/model/user_model.dart';
import 'package:recipe/feature/auth/domain/entities/sign_with_email_entities.dart';

typedef GetUser = Either<FailerHandler, SuccessHandler<UserModel>>;
typedef EitherBoolOrInt = Either<bool, int>;

class AuthDataSourceRepoImpl implements AuthDataRepo {

  final RemoteDataRepo remoteData;
  final LocalDataRepo localData;

  AuthDataSourceRepoImpl({required this.remoteData, required this.localData});

  @override
  Future<GetUser> loginWithEmail(LoginWithEmailModel entities) async {
    final result = await remoteData.loginWithEmail(entities);
    return await result.fold((failer) => Left(failer), (success) async {
      await localData.addUser(success.data);
      return Right(success);
    });
  }

  @override
  Future<GetUser> loginWithGoogle() async {
    final result = await remoteData.loginWithGoogle();
    return await result.fold((failer) => Left(failer), (success) async {
      await localData.addUser(success.data);
      return Right(success);
    });
  }

  @override
  Future<EitherBoolOrInt> logout() async{
   return await remoteData.logout();
  }

  @override
  Future<GetUser> registerWithEmail(SignWithEmailEntities entities) async {
    final result = await remoteData.registerWithEmail(entities);
    return await result.fold((failer) => Left(failer), (success) async {
      await localData.addUser(success.data);
      return Right(success);
    });
  }

  @override
  Future<GetUser> registerWithGoogle() async {
    final result = await remoteData.registerWithGoogle();
    return await result.fold((failer) => Left(failer), (success) async {
      await localData.addUser(success.data);
      return Right(success);
    });
  }

}
