import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';

part 'selectedcategory_state.dart';

class SelectedcategoryCubit extends Cubit<SelectedcategoryState> {
  SelectedcategoryCubit() : super(const SelectedcategoryInitial(null));
}
