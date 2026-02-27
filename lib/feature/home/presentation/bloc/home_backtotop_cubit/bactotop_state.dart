part of 'bactotop_cubit.dart';

sealed class BactotopState extends Equatable {
  const BactotopState();

  @override
  List<Object> get props => [];
}

final class BactotopInitial extends BactotopState {}

final class BactotopShow extends BactotopState {}

final class BactotopHide extends BactotopState {}