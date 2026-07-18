import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe/core/extensions/localization_extension.dart';

class ErrorMessages {
 static String getGoogleSignInErrorMessage(GoogleSignInExceptionCode code) =>
      switch (code) {
        GoogleSignInExceptionCode.canceled => "You cancelled the login.",

        GoogleSignInExceptionCode.interrupted =>
          "Login was interrupted. Please try again.",

        GoogleSignInExceptionCode.clientConfigurationError =>
          "App is not configured properly for Google sign-in.",

        GoogleSignInExceptionCode.providerConfigurationError =>
          "Google login service is not available right now.",

        GoogleSignInExceptionCode.uiUnavailable =>
          "Unable to open Google login screen on this device.",

        GoogleSignInExceptionCode.userMismatch =>
          "This account does not match the currently logged-in user.",

        GoogleSignInExceptionCode.unknownError =>
          "Something went wrong. Please try again.",
      };

  static String getFirebaseErrorMessage(String code) => switch (code) {
    "invalid-email" =>
      "The email address you entered is not valid. Please check and try again.",
    "user-disabled" =>
      "This account has been disabled. Please contact support.",
    "user-not-found" =>
      "No account found with this email. Please sign up first.",
    "wrong-password" => "Incorrect password. Please try again.",
    "email-already-in-use" =>
      "This email is already registered. Please use another email.",
    "operation-not-allowed" =>
      "Email/Password sign-in is not enabled. Please contact support.",
    "too-many-requests" => "Too many login attempts. Please try again later.",
    "network-request-failed" =>
      "Network error. Check your internet connection and try again.",
    "weak-password" =>
      "The password is too weak. Please use a stronger password.",
    "requires-recent-login" =>
      "For security reasons, please log in again to continue.",
    "account-exists-with-different-credential" =>
      "An account already exists with a different sign-in method.",
    "invalid-credential" =>
      "The login credential has expired or is invalid. Please try again.",
    _ => "Something went wrong. Please try again later.",
  };

  static String getLocalizedMessage(BuildContext context, String message) {
    return switch (message) {
      "You cancelled the login." => context.l10n.err_login_cancelled,
      "Login was interrupted. Please try again." => context.l10n.err_login_interrupted,
      "App is not configured properly for Google sign-in." => context.l10n.err_client_config,
      "Google login service is not available right now." => context.l10n.err_provider_config,
      "Unable to open Google login screen on this device." => context.l10n.err_ui_unavailable,
      "This account does not match the currently logged-in user." => context.l10n.err_user_mismatch,
      "Something went wrong. Please try again." => context.l10n.err_unknown,
      "The email address you entered is not valid. Please check and try again." => context.l10n.err_invalid_email,
      "This account has been disabled. Please contact support." => context.l10n.err_user_disabled,
      "No account found with this email. Please sign up first." => context.l10n.err_user_not_found,
      "Incorrect password. Please try again." => context.l10n.err_wrong_password,
      "This email is already registered. Please use another email." => context.l10n.err_email_already_in_use,
      "Email/Password sign-in is not enabled. Please contact support." => context.l10n.err_operation_not_allowed,
      "Too many login attempts. Please try again later." => context.l10n.err_too_many_requests,
      "Network error. Check your internet connection and try again." => context.l10n.err_network_request_failed,
      "The password is too weak. Please use a stronger password." => context.l10n.err_weak_password,
      "For security reasons, please log in again to continue." => context.l10n.err_requires_recent_login,
      "An account already exists with a different sign-in method." => context.l10n.err_account_exists_with_different_credential,
      "The login credential has expired or is invalid. Please try again." => context.l10n.err_invalid_credential,
      "Something went wrong. Please try again later." => context.l10n.err_something_went_wrong_later,
      _ => message,
    };
  }
}
