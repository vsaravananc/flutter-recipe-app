import "package:flutter/material.dart";

class AuthDividerHolderWidget extends StatelessWidget {
  final String text;
  const AuthDividerHolderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      spacing: 8,
      children: [
        Expanded(child: Divider(color: Theme.of(context).dividerColor)),
        Text("Or $text with", style: Theme.of(context).textTheme.bodySmall),
        Expanded(child: Divider(color: Theme.of(context).dividerColor)),
      ],
    );
  }
}
