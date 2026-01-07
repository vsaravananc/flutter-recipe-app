import 'package:equatable/equatable.dart';

class DetailEntite extends Equatable {
  final String mealId;
  final String mealName;
  final String mealAlternate;
  final String mealArea;
  final String mealInstruction;
  final String mealThumbImage;
  final String mealTag;
  final String mealCookingVideo;
  final List<MealIntegration> mealIntegrationCollection;
  final List<MealMeasure> mealMeasureCollection;
  final String mealSource;
  final String mealSourceImage;

  const DetailEntite({
    required this.mealId,
    required this.mealName,
    required this.mealAlternate,
    required this.mealArea,
    required this.mealInstruction,
    required this.mealThumbImage,
    required this.mealTag,
    required this.mealCookingVideo,
    required this.mealIntegrationCollection,
    required this.mealMeasureCollection,
    required this.mealSource,
    required this.mealSourceImage,
  });

  @override
  List<Object> get props => [
    mealId,
    mealName,
    mealAlternate,
    mealArea,
    mealInstruction,
    mealThumbImage,
    mealTag,
    mealCookingVideo,
    mealIntegrationCollection,
    mealMeasureCollection,
    mealSource,
    mealSourceImage,
  ];
}

class MealIntegration extends Equatable {
  final String integration;

  const MealIntegration({required this.integration});

  @override
  List<Object> get props => [integration];
}

class MealMeasure extends Equatable {
  final String measure;
  const MealMeasure({required this.measure});
  @override
  List<Object?> get props => [];
}
