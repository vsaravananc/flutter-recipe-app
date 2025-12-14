import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/use_cases/select_area_use_case.dart';

part 'selectedarea_state.dart';

class SelectedareaCubit extends Cubit<SelectedareaState> {
  final SelectAreaUseCase selectAreaUseCase;
  SelectedareaCubit({required this.selectAreaUseCase})
    : super(const SelectedareaInitial());

  Future<void> selectArea(AreaEntities area) async {
    emit(SelectedAreaState(areaEntities: area));
    await selectAreaUseCase.selectArea(area);
  }
}
