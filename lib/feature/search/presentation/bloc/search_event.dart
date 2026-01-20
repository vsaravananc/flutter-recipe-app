part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class TriggerSearchEvent extends SearchEvent {
  final String search;

  const TriggerSearchEvent({required this.search});

  @override
  List<Object> get props => [search];
}
