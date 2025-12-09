import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/auth/domain/entities/sign_with_email_entities.dart';
import 'package:recipe/feature/auth/domain/entities/user_entities.dart';
import 'package:recipe/feature/auth/domain/repo/auth_repo.dart';

class SignupWithEmailUsecase {
  final AuthRepo authRepo;
  const SignupWithEmailUsecase({required this.authRepo});

  Future<Either<FailerHandler, SuccessHandler<UserEntities>>> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    return await authRepo.registerWithEmail(
      SignWithEmailEntities(email: email, name: name, password: password),
    );
  }
}
