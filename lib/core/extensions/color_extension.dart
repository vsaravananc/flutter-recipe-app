import 'package:flutter/material.dart';

///
/// This extension will provide as short cut to use Color in our project
///

extension ColorExtension on BuildContext{
  // -----------------------------
  // Theme Colors
  // -----------------------------
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get cardColor => Theme.of(this).cardColor;
  Color get dividerColor => Theme.of(this).dividerColor;
  Color get shadowColor => Theme.of(this).shadowColor;
  Color get canvasColor => Theme.of(this).canvasColor;
  Color get focusColor => Theme.of(this).focusColor;
  Color get hoverColor => Theme.of(this).hoverColor;
  Color get highlightColor => Theme.of(this).highlightColor;
  Color get splashColor => Theme.of(this).splashColor;
  Color get disabledColor => Theme.of(this).disabledColor;

  // -----------------------------
  // ColorScheme Colors
  // -----------------------------
  ColorScheme get _scheme => Theme.of(this).colorScheme;

  Color get primary => _scheme.primary;
  Color get onPrimary => _scheme.onPrimary;
  Color get primaryContainer => _scheme.primaryContainer;
  Color get onPrimaryContainer => _scheme.onPrimaryContainer;

  Color get secondary => _scheme.secondary;
  Color get onSecondary => _scheme.onSecondary;
  Color get secondaryContainer => _scheme.secondaryContainer;
  Color get onSecondaryContainer => _scheme.onSecondaryContainer;

  Color get tertiary => _scheme.tertiary;
  Color get onTertiary => _scheme.onTertiary;
  Color get tertiaryContainer => _scheme.tertiaryContainer;
  Color get onTertiaryContainer => _scheme.onTertiaryContainer;

  Color get error => _scheme.error;
  Color get onError => _scheme.onError;
  Color get errorContainer => _scheme.errorContainer;
  Color get onErrorContainer => _scheme.onErrorContainer;

  Color get background => _scheme.background;
  Color get onBackground => _scheme.onBackground;

  Color get surface => _scheme.surface;
  Color get onSurface => _scheme.onSurface;
  Color get surfaceVariant => _scheme.surfaceVariant;
  Color get onSurfaceVariant => _scheme.onSurfaceVariant;

  Color get outline => _scheme.outline;
  Color get outlineVariant => _scheme.outlineVariant;
  Color get shadow => _scheme.shadow;
  Color get scrim => _scheme.scrim;

  Color get inverseSurface => _scheme.inverseSurface;
  Color get onInverseSurface => _scheme.onInverseSurface;
  Color get inversePrimary => _scheme.inversePrimary;

  //----------------------------------------------------------------------
  // custom colors
  //----------------------------------------------------------------------

  Color get transprent => Colors.transparent;

}