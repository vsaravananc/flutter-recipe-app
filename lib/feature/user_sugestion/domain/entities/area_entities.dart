import 'package:equatable/equatable.dart';

class AreaEntities extends Equatable {
  final String area;
  const AreaEntities({required this.area});
  @override
  List<Object?> get props => [area];
}
