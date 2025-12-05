import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/feature/auth/domain/entities/login_with_email_entities.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

}
