import 'package:flutter/material.dart';

class WelcomeInfoWidget extends StatelessWidget {
  final String info;
  const WelcomeInfoWidget({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        info,
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: .center,
      ),
    );
  }
}
