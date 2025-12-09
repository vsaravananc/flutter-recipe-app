import 'package:google_sign_in/google_sign_in.dart';

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
}
