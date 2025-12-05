import 'package:flutter/material.dart';

class WelcomeImageWidget extends StatelessWidget {
  final String image;
  const WelcomeImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      child: SizedBox(
        height: 300,
        width: 300,
        child: Image.asset(image, cacheHeight: 300, width: 300),
      ),
    );
  }
}
