import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/services/dimensions.dart';

class HomeRecipePlaceholderWidget extends StatelessWidget {
  const HomeRecipePlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(Dimensions.p16),
      child: Image.asset(AppImages.recipePlaceHolder, fit: .fitHeight),
    );
  }
}
