import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';
class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: 80,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.logoLight),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
