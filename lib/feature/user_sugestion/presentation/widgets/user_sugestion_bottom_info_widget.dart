import 'package:flutter/material.dart';
import 'package:recipe/core/extensions/localization_extension.dart';

class UserSugestionBottomInfoWidget extends StatelessWidget {
  final String title;
  const UserSugestionBottomInfoWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(title),
      height: 35,
      margin: EdgeInsets.fromLTRB(
        10,
        0,
        10,
        MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child:  Center(
        child: Row(
          mainAxisAlignment: .center,
          spacing: 10,
          children: [
           const Icon(Icons.info_outlined),
            Text(context.l10n.suggestion_bottom_info(title)),
          ],
        ),
      ),
    );
  }
}
