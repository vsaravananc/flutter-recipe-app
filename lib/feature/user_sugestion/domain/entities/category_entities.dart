import 'package:equatable/equatable.dart';

class CategoryEntities extends Equatable {
  final String category;
  const CategoryEntities({required this.category});
  @override
  List<Object?> get props => [category];
}
