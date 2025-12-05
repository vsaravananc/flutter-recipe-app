import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_image_widget.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_info_widget.dart';

class WelcomeThree extends StatelessWidget {
  const WelcomeThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        WelcomeImageWidget(
          image: AppImages.welcome3,
          key: ValueKey('welcome_image_holder_3'),
        ),
        SizedBox(height: kToolbarHeight),
        WelcomeInfoWidget(
          info: "Save your favorite and cook your way every day.",
          key: ValueKey('welcome_info_holder_3'),
        ),
      ],
    );
  }
}
