import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const AuthButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: ValueKey(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size.fromHeight(50),
        elevation: 1,
        shadowColor: Theme.of(context).shadowColor,
        splashFactory: InkRipple.splashFactory,
        overlayColor: Theme.of( context).colorScheme.onPrimaryContainer,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
