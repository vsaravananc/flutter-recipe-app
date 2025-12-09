import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/feature/auth/domain/entities/user_entities.dart';
import 'package:recipe/feature/auth/domain/use_cases/login_with_email_usecase.dart';
import 'package:recipe/feature/auth/domain/use_cases/login_with_google_usecase.dart';
import 'package:recipe/feature/auth/domain/use_cases/signup_with_email_usecase.dart';
import 'package:recipe/feature/auth/domain/use_cases/signup_with_google_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmailUsecase login;
  final SignupWithEmailUsecase sigup;
  final LoginWithGoogleUsecase google;
  final SignupWithGoogleUsecase registerGoogle;
  AuthBloc({
    required this.login,
    required this.sigup,
    required this.google,
    required this.registerGoogle,
  }) : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await login(email: event.email, password: event.password);
      result.fold(
        (failer) => emit(AuthError(message: failer.message)),
        (sucess) => emit(AuthSuccess(user: sucess.data)),
      );
    });
    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await sigup.signUp(
        email: event.email,
        name: event.name,
        password: event.password,
      );
      result.fold(
        (failer) => emit(AuthError(message: failer.message)),
        (sucess) => emit(AuthSuccess(user: sucess.data)),
      );
    });
    on<AuthLoginWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await google.loginWithGoogle();
      result.fold(
        (failer) => emit(AuthError(message: failer.message)),
        (sucess) => emit(AuthSuccess(user: sucess.data)),
      );
    });
    on<AuthSignUpWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await registerGoogle.signupWithGoogle();
      result.fold(
        (failer) => emit(AuthError(message: failer.message)),
        (sucess) => emit(AuthSuccess(user: sucess.data)),
      );
    });
  }
}
