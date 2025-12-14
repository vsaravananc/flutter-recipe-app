import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/core/extensions/color_extension.dart';
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
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      surfaceTintColor: context.scaffoldBackgroundColor,
      backgroundColor: context.scaffoldBackgroundColor,
      automaticallyImplyLeading: leadingIcon,
      leading: leadingIcon
          ? IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
