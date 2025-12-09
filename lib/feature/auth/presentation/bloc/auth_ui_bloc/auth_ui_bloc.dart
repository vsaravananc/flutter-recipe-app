import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_ui_event.dart';
part 'auth_ui_state.dart';

class AuthUIBloc extends Bloc<AuthUIEvent, AuthUIState> {
  AuthUIBloc() : super(AuthLogin()) {
    on<AuthChangeLogIn>((event, emit) {
      emit(AuthLogin());
    });

    on<AuthChangeSignUP>((event, emit) {
      emit(AuthSignUp());
    });
  }
}
