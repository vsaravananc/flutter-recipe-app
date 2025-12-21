import 'package:equatable/equatable.dart';

class HomeCategoryEntities extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  const HomeCategoryEntities({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, description];
}
