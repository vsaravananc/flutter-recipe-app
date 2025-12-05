import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_image_widget.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_info_widget.dart';

class WelcomeOne extends StatelessWidget {
  const WelcomeOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        WelcomeImageWidget(
          image: AppImages.welcome1,
          key: ValueKey('welcome_image_holder_1'),
        ),
        SizedBox(height: kToolbarHeight),
        WelcomeInfoWidget(
          info: "Find healthy and delicious meals you'll love",
          key: ValueKey('welcome_info_holder_1'),
        ),
      ],
    );
  }
}
