part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchResult extends SearchState{
  final List<SearchRecipeEntities> searchResult;
  const SearchResult({required this.searchResult});

  @override
  List<Object> get props => [searchResult];
}