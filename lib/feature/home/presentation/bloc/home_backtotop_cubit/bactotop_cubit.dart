import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bactotop_state.dart';

class BactotopCubit extends Cubit<BactotopState> {
  BactotopCubit() : super(BactotopInitial());

  void show() => emit(BactotopShow());
  void hide() => emit(BactotopHide());
  
}
