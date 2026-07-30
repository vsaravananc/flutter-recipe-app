import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/services/dimensions.dart';

class HomeRecipePlaceholderWidget extends StatelessWidget {
  final int width;
  final int height;
  const HomeRecipePlaceholderWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(Dimensions.p16),
      child: Image.asset(
        AppImages.recipePlaceHolder,
        fit: .fitHeight,
        cacheHeight: height,
        cacheWidth: width,
      ),
    );
  }
}
