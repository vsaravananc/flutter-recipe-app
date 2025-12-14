import 'package:flutter/material.dart';

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
            Text("Choose a $title. Can be updated later in Settings"),
          ],
        ),
      ),
    );
  }
}
