

import 'package:flutter/material.dart';

///
/// This extension will provide as short cut to use text style in our project
///

extension TextstyleExtension on BuildContext {
 TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
 TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
 TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

 TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;
 TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
 TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

 TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;
 TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;
 TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;

 TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;
 TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;
 TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

 TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
 TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
 TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;

}