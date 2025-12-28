import 'package:flutter/material.dart';

class GradintThemeExtenstion extends ThemeExtension<GradintThemeExtenstion> {
  final List<Color> colors;

  const GradintThemeExtenstion({required this.colors});

  @override
  GradintThemeExtenstion copyWith({List<Color>? colors}) {
    return GradintThemeExtenstion(colors: colors ?? this.colors);
  }

  @override
  GradintThemeExtenstion lerp(
    covariant ThemeExtension<GradintThemeExtenstion>? other,
    double t,
  ) {
    if (other is! GradintThemeExtenstion) {
      return this;
    }

    if (colors.length != other.colors.length) {
      return this;
    }

    return GradintThemeExtenstion(
      colors: List.generate(colors.length, (index) {
        return Color.lerp(colors[index], other.colors[index], t)!;
      }),
    );
  }
}
