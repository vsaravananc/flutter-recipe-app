part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class GetDetailData extends DetailEvent {
  final String detailId;
  const GetDetailData({required this.detailId});

  @override
  List<Object> get props => [detailId];
}

class JustChangeState extends DetailEvent {}
