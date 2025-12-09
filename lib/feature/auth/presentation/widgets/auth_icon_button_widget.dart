import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';

class AuthIconButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const AuthIconButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      key: ValueKey(text),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size.fromHeight(50),
        elevation: 1,
        shadowColor: Theme.of(context).shadowColor,
        splashFactory: InkRipple.splashFactory,
      ),
      onPressed: onPressed,
      icon: Image.asset(AppImages.goole, height: 25, width: 25),
      label: Text(
        "$text with Google",
        style: Theme.of(
          context,
        ).textTheme.titleLarge,
      ),
    );
  }
}
