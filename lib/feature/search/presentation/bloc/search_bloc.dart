import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/feature/search/domain/entities/search_entities.dart';
import 'package:recipe/feature/search/domain/usecase/search_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUsecase searchUsecase;
  SearchBloc({required this.searchUsecase}) : super(SearchInitial()) {
    on<TriggerInitalEvent>((event, emit) => emit(SearchInitial()));

    on<TriggerSearchEvent>((event, emit) async {
      if (event.search.isEmpty) return;
      final response = await searchUsecase.searchRecipe(event.search);
      response.fold(
        (failer) => emit(SearchInitial()),
        (sucess) => emit(SearchResult(searchResult: sucess.data)),
      );
    });
  }
}
