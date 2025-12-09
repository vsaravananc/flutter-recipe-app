import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/auth/domain/entities/login_with_email_entities.dart';
import 'package:recipe/feature/auth/domain/entities/user_entities.dart';
import 'package:recipe/feature/auth/domain/repo/auth_repo.dart';

class LoginWithEmailUsecase {
  final AuthRepo authRepo;

  LoginWithEmailUsecase({required this.authRepo});

  Future<Either<FailerHandler, SuccessHandler<UserEntities>>> call({
    required String email,
    required String password,
  }) async {
    return await authRepo.loginWithEmail(
      LoginWithEmailEntities(email: email, password: password),
    );
  }
}
