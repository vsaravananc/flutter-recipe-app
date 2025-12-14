import 'package:flutter/material.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';

class UserSugestionSelectButtonWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onTap;
  const UserSugestionSelectButtonWidget({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? context.primary : context.tertiaryContainer,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        splashColor: context.secondary,
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: context.transprent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              style: isSelected
                  ? context.bodyLarge!.copyWith(
                      color: context.onPrimary,
                      fontWeight: FontWeight.w900,
                    )
                  : context.bodyLarge!.copyWith(
                      color: context.onTertiaryContainer,
                      fontWeight: FontWeight.w400,
                    ),
              duration: const Duration(milliseconds: 300),
              child: Text(title),
            ),
          ),
        ),
      ),
    );
  }
}
