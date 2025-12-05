import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';

class AuthLogoHolderWidget extends StatelessWidget {
  const AuthLogoHolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Image.asset(AppImages.logoDark, height: 50, width: 50),
          Text("Recipe Book", style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
