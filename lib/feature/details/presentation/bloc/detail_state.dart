part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitialLoading extends DetailState {}

class DetailHaveData extends DetailState {
  final DetailEntite detailEntite;
  const DetailHaveData({required this.detailEntite});

  @override
  List<Object> get props => [detailEntite];
}

class DetailFailedData extends DetailState {
  final FailerHandler failerHandler;
  const DetailFailedData({required this.failerHandler});

  @override
  List<Object> get props => [failerHandler];
}
