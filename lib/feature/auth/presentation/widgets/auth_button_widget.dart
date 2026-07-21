import 'package:flutter/material.dart';
import 'package:recipe/core/util/app_color.dart';

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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        key: ValueKey(text),
        decoration: ShapeDecoration(
          color: AppColor.primary,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        constraints: const BoxConstraints(
          minHeight: 48,
          minWidth: double.infinity,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
