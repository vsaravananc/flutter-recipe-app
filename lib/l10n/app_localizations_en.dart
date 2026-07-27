// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'ALL-IN-ONE';

  @override
  String get auth_already_have_account => 'Already have an account? ';

  @override
  String get auth_app_title => 'Recipe Book';

  @override
  String get auth_dont_have_account => 'Don’t have an account? ';

  @override
  String get auth_email => 'Email';

  @override
  String get auth_facebook => 'Facebook';

  @override
  String get auth_fullname => 'Full Name';

  @override
  String get auth_google => 'Google';

  @override
  String get auth_hint_email => 'Enter your email';

  @override
  String get auth_hint_fullname => 'Enter your full name';

  @override
  String get auth_hint_password => 'Enter your password';

  @override
  String get auth_login_link => 'Log In';

  @override
  String get auth_login_subtitle => 'Enter your credentials to access your account';

  @override
  String get auth_login_title => 'Hey, Hello 👋';

  @override
  String get auth_password => 'Password';

  @override
  String get auth_register => 'Register';

  @override
  String get auth_sign_in => 'Sign In';

  @override
  String get auth_sign_up => 'Sign Up';

  @override
  String get auth_signup_success_msg => 'Successfully registered as user.';

  @override
  String get common_next => 'Next';

  @override
  String get common_or => 'or';

  @override
  String get common_skip => 'Skip';

  @override
  String get dashboard_scanner => 'Scanner';

  @override
  String get details_ingredients => 'Ingredients';

  @override
  String get details_instructions => 'Instructions';

  @override
  String get details_recipe_video => 'Recipe Video';

  @override
  String get err_account_exists_with_different_credential => 'An account already exists with a different sign-in method.';

  @override
  String get err_client_config => 'App is not configured properly for Google sign-in.';

  @override
  String get err_email_already_in_use => 'This email is already registered. Please use another email.';

  @override
  String get err_invalid_credential => 'The login credential has expired or is invalid. Please try again.';

  @override
  String get err_invalid_email => 'The email address you entered is not valid. Please check and try again.';

  @override
  String get err_login_cancelled => 'You cancelled the login.';

  @override
  String get err_login_interrupted => 'Login was interrupted. Please try again.';

  @override
  String get err_network_request_failed => 'Network error. Check your internet connection and try again.';

  @override
  String get err_operation_not_allowed => 'Email/Password sign-in is not enabled. Please contact support.';

  @override
  String get err_provider_config => 'Google login service is not available right now.';

  @override
  String get err_requires_recent_login => 'For security reasons, please log in again to continue.';

  @override
  String get err_something_went_wrong_later => 'Something went wrong. Please try again later.';

  @override
  String get err_too_many_requests => 'Too many login attempts. Please try again later.';

  @override
  String get err_ui_unavailable => 'Unable to open Google login screen on this device.';

  @override
  String get err_user_disabled => 'This account has been disabled. Please contact support.';

  @override
  String get err_user_mismatch => 'This account does not match the currently logged-in user.';

  @override
  String get err_user_not_found => 'No account found with this email. Please sign up first.';

  @override
  String get err_weak_password => 'The password is too weak. Please use a stronger password.';

  @override
  String get err_wrong_password => 'Incorrect password. Please try again.';

  @override
  String get err_unknown => 'Something went wrong. Please try again.';

  @override
  String get home => 'Home';

  @override
  String get home_back_to_top => 'Back to Top';

  @override
  String get home_hello_prefix => 'Hello,';

  @override
  String get home_quote_goes_into_cooking => ' goes into cooking and desire comes to the table.';

  @override
  String get home_quote_love => ' love';

  @override
  String get home_quote_where => 'Where';

  @override
  String get home_recipes_title => 'Recipes';

  @override
  String get home_search_hint => 'Search any recipe';

  @override
  String get home_username => ' John Doe!';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get profile_title => 'Profile';

  @override
  String get scanner_hint => 'Scan your barcode';

  @override
  String get scanner_home_title => 'Scanner Home';

  @override
  String get search_hint_example => 'Briyani Recipe';

  @override
  String get search_title => 'Search Recipe';

  @override
  String get settings => 'Settings';

  @override
  String get splash_created_by => 'Created with ❤️ by ';

  @override
  String get splash_developer_name => 'Saravanan V';

  @override
  String splash_version(String version) {
    return 'Version: $version';
  }

  @override
  String suggestion_bottom_info(String title) {
    return 'Choose a $title. Can be updated later in Settings';
  }

  @override
  String get suggestion_category => 'category';

  @override
  String get suggestion_country => 'country';

  @override
  String get suggestion_no_areas_found => 'No areas found';

  @override
  String get suggestion_select_category_title => 'Select a Category for Recipes';

  @override
  String get suggestion_select_country_title => 'Select a Country for Recipes';

  @override
  String get val_email_invalid => 'Enter a valid email';

  @override
  String get val_email_required => 'Email is required';

  @override
  String get val_name_required => 'Full Name is required';

  @override
  String get val_password_required => 'Password is required';

  @override
  String val_password_short(int length) {
    return 'Password must be at least $length characters';
  }

  @override
  String get version => 'Version';

  @override
  String welcome(String name) {
    return 'Welcome $name';
  }

  @override
  String get welcome_discover_recipes => 'Discover delicious recipes and cooking tips from around the world.';

  @override
  String get welcome_get_started => 'Get Started';

  @override
  String get welcome_lorem_ipsum => 'Lorem ipsum dolor sit amet, consectetur adip happy to see you but you\'r';

  @override
  String get welcome_slide1_part1 => 'Save and Organize ';

  @override
  String get welcome_slide1_part2 => 'Your Best Recipes.';

  @override
  String get welcome_slide2_part1 => 'Explore a ';

  @override
  String get welcome_slide2_part2 => 'World of ';

  @override
  String get welcome_slide2_part3 => 'Culinary ';

  @override
  String get welcome_slide2_part4 => 'Delights';

  @override
  String get welcome_slide3_part1 => 'Interactive Cooking : ';

  @override
  String get welcome_slide3_part2 => 'Join the Chef in real time.';

  @override
  String get welcome_your_recipe_heaven_part1 => 'Your ';

  @override
  String get welcome_your_recipe_heaven_part2 => 'Recipe Heaven';

  @override
  String get welcome_your_recipe_heaven_part3 => '\nAwaits Exploration!';
}
