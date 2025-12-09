import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/auth/domain/entities/user_entities.dart';
import 'package:recipe/feature/auth/domain/repo/auth_repo.dart';

class SignupWithGoogleUsecase {
  final AuthRepo authRepo;
  const SignupWithGoogleUsecase({required this.authRepo});

  Future<Either<FailerHandler, SuccessHandler<UserEntities>>>
  signupWithGoogle() async {
    return await authRepo.registerWithGoogle();
  }
}
