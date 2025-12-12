import 'package:flutter/material.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool leadingIcon;
  const AppBarWidget({
    super.key,
    required this.title,
    this.leadingIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: context.titleLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      automaticallyImplyLeading: leadingIcon,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
