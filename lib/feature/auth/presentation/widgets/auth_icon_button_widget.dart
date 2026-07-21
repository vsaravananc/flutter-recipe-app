import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthIconButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String imagePath;
  const AuthIconButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(

      key: ValueKey(text),
      style: ElevatedButton.styleFrom(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        minimumSize: const Size.fromHeight(50),
        elevation: 0,
        shadowColor: Colors.transparent,
        splashFactory: InkRipple.splashFactory,
        side: BorderSide(
          width: 1.1,
          color: Theme.of(context).colorScheme.outline,
        )
      ),
      onPressed: onPressed,
      icon: SvgPicture.asset(
        imagePath,
        fit: BoxFit.contain,
        height: 25,
        width: 25,
      ),
      label: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleMedium,
      ),
    );
  }
}
