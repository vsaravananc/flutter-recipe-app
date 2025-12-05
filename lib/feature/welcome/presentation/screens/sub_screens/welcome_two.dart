import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_image_widget.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_info_widget.dart';

class WelcomeTwo extends StatelessWidget {
  const WelcomeTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        WelcomeImageWidget(
          image: AppImages.welcome2,
          key: ValueKey('welcome_image_holder_2'),
        ),
        SizedBox(height: kToolbarHeight),
        WelcomeInfoWidget(
          info: "Discover thousands of recipes at your fingertips",
          key: ValueKey('welcome_info_holder_2'),
        ),
      ],
    );
  }
}
