import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';

class HomeCategoryPlaceholderWidget extends StatelessWidget {
  const HomeCategoryPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return SizedBox(
      height: 55,
      width: 55,
      child: ClipRRect(
        borderRadius: .circular(27.5),
        child: Image.asset(
          AppImages.categoryPlaceHolder,
          cacheHeight: (55 * dpr).toInt(),
          cacheWidth: (55 * dpr).toInt(),
        ),
      ),
    );
  }
}
