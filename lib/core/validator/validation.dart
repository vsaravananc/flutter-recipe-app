import 'package:flutter/material.dart';
import 'package:recipe/core/extensions/localization_extension.dart';

class Validation {
  static String? email(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.l10n.val_email_required;
    }
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value)) {
      return context.l10n.val_email_invalid;
    }
    return null;
  }

  static String? name(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.l10n.val_name_required;
    }
    return null;
  }

  static String? password(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.l10n.val_password_required;
    }
    if (value.length < 6) {
      return context.l10n.val_password_short(6);
    }
    return null;
  }
}
