import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class DetailScreenlEntitie extends Equatable {
  final String id;
  final String title;
  final String titleTag;
  final String image;
  final String imageTag;

  const DetailScreenlEntitie({
    required this.title,
    required this.titleTag,
    required this.image,
    required this.imageTag,
    required this.id,
  });

  @override
  List<Object?> get props => [id, title, titleTag, image, imageTag];
}
