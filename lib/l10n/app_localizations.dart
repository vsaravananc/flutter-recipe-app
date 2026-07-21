import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ta.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ta')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'ALL-IN-ONE'**
  String get appName;

  /// No description provided for @auth_already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get auth_already_have_account;

  /// No description provided for @auth_app_title.
  ///
  /// In en, this message translates to:
  /// **'Recipe Book'**
  String get auth_app_title;

  /// No description provided for @auth_dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get auth_dont_have_account;

  /// No description provided for @auth_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get auth_email;

  /// No description provided for @auth_facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get auth_facebook;

  /// No description provided for @auth_fullname.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get auth_fullname;

  /// No description provided for @auth_google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get auth_google;

  /// No description provided for @auth_hint_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get auth_hint_email;

  /// No description provided for @auth_hint_fullname.
  ///
  /// In en, this message translates to:
  /// **'Enter your Full Name'**
  String get auth_hint_fullname;

  /// No description provided for @auth_hint_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your Password'**
  String get auth_hint_password;

  /// No description provided for @auth_login_link.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get auth_login_link;

  /// No description provided for @auth_login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials to access your account'**
  String get auth_login_subtitle;

  /// No description provided for @auth_login_title.
  ///
  /// In en, this message translates to:
  /// **'Hey, Hello 👋'**
  String get auth_login_title;

  /// No description provided for @auth_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_password;

  /// No description provided for @auth_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get auth_register;

  /// No description provided for @auth_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get auth_sign_in;

  /// No description provided for @auth_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get auth_sign_up;

  /// No description provided for @auth_signup_success_msg.
  ///
  /// In en, this message translates to:
  /// **'Successfully registered as user.'**
  String get auth_signup_success_msg;

  /// No description provided for @common_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get common_next;

  /// No description provided for @common_or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get common_or;

  /// No description provided for @common_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get common_skip;

  /// No description provided for @dashboard_scanner.
  ///
  /// In en, this message translates to:
  /// **'Scanner'**
  String get dashboard_scanner;

  /// No description provided for @details_ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get details_ingredients;

  /// No description provided for @details_instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get details_instructions;

  /// No description provided for @details_recipe_video.
  ///
  /// In en, this message translates to:
  /// **'Recipe Video'**
  String get details_recipe_video;

  /// No description provided for @err_account_exists_with_different_credential.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with a different sign-in method.'**
  String get err_account_exists_with_different_credential;

  /// No description provided for @err_client_config.
  ///
  /// In en, this message translates to:
  /// **'App is not configured properly for Google sign-in.'**
  String get err_client_config;

  /// No description provided for @err_email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered. Please use another email.'**
  String get err_email_already_in_use;

  /// No description provided for @err_invalid_credential.
  ///
  /// In en, this message translates to:
  /// **'The login credential has expired or is invalid. Please try again.'**
  String get err_invalid_credential;

  /// No description provided for @err_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'The email address you entered is not valid. Please check and try again.'**
  String get err_invalid_email;

  /// No description provided for @err_login_cancelled.
  ///
  /// In en, this message translates to:
  /// **'You cancelled the login.'**
  String get err_login_cancelled;

  /// No description provided for @err_login_interrupted.
  ///
  /// In en, this message translates to:
  /// **'Login was interrupted. Please try again.'**
  String get err_login_interrupted;

  /// No description provided for @err_network_request_failed.
  ///
  /// In en, this message translates to:
  /// **'Network error. Check your internet connection and try again.'**
  String get err_network_request_failed;

  /// No description provided for @err_operation_not_allowed.
  ///
  /// In en, this message translates to:
  /// **'Email/Password sign-in is not enabled. Please contact support.'**
  String get err_operation_not_allowed;

  /// No description provided for @err_provider_config.
  ///
  /// In en, this message translates to:
  /// **'Google login service is not available right now.'**
  String get err_provider_config;

  /// No description provided for @err_requires_recent_login.
  ///
  /// In en, this message translates to:
  /// **'For security reasons, please log in again to continue.'**
  String get err_requires_recent_login;

  /// No description provided for @err_something_went_wrong_later.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get err_something_went_wrong_later;

  /// No description provided for @err_too_many_requests.
  ///
  /// In en, this message translates to:
  /// **'Too many login attempts. Please try again later.'**
  String get err_too_many_requests;

  /// No description provided for @err_ui_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unable to open Google login screen on this device.'**
  String get err_ui_unavailable;

  /// No description provided for @err_user_disabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled. Please contact support.'**
  String get err_user_disabled;

  /// No description provided for @err_user_mismatch.
  ///
  /// In en, this message translates to:
  /// **'This account does not match the currently logged-in user.'**
  String get err_user_mismatch;

  /// No description provided for @err_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'No account found with this email. Please sign up first.'**
  String get err_user_not_found;

  /// No description provided for @err_weak_password.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak. Please use a stronger password.'**
  String get err_weak_password;

  /// No description provided for @err_wrong_password.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password. Please try again.'**
  String get err_wrong_password;

  /// No description provided for @err_unknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get err_unknown;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @home_back_to_top.
  ///
  /// In en, this message translates to:
  /// **'Back to Top'**
  String get home_back_to_top;

  /// No description provided for @home_hello_prefix.
  ///
  /// In en, this message translates to:
  /// **'Hello,'**
  String get home_hello_prefix;

  /// No description provided for @home_quote_goes_into_cooking.
  ///
  /// In en, this message translates to:
  /// **' goes into cooking and desire comes to the table.'**
  String get home_quote_goes_into_cooking;

  /// No description provided for @home_quote_love.
  ///
  /// In en, this message translates to:
  /// **' love'**
  String get home_quote_love;

  /// No description provided for @home_quote_where.
  ///
  /// In en, this message translates to:
  /// **'Where'**
  String get home_quote_where;

  /// No description provided for @home_recipes_title.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get home_recipes_title;

  /// No description provided for @home_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search any recipe'**
  String get home_search_hint;

  /// No description provided for @home_username.
  ///
  /// In en, this message translates to:
  /// **' John Doe!'**
  String get home_username;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @scanner_hint.
  ///
  /// In en, this message translates to:
  /// **'Scan your barcode'**
  String get scanner_hint;

  /// No description provided for @scanner_home_title.
  ///
  /// In en, this message translates to:
  /// **'Scanner Home'**
  String get scanner_home_title;

  /// No description provided for @search_hint_example.
  ///
  /// In en, this message translates to:
  /// **'Briyani Recipe'**
  String get search_hint_example;

  /// No description provided for @search_title.
  ///
  /// In en, this message translates to:
  /// **'Search Recipe'**
  String get search_title;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @splash_created_by.
  ///
  /// In en, this message translates to:
  /// **'Created with ❤️ by '**
  String get splash_created_by;

  /// No description provided for @splash_developer_name.
  ///
  /// In en, this message translates to:
  /// **'Saravanan V'**
  String get splash_developer_name;

  /// No description provided for @splash_version.
  ///
  /// In en, this message translates to:
  /// **'Version: {version}'**
  String splash_version(String version);

  /// No description provided for @suggestion_bottom_info.
  ///
  /// In en, this message translates to:
  /// **'Choose a {title}. Can be updated later in Settings'**
  String suggestion_bottom_info(String title);

  /// No description provided for @suggestion_category.
  ///
  /// In en, this message translates to:
  /// **'category'**
  String get suggestion_category;

  /// No description provided for @suggestion_country.
  ///
  /// In en, this message translates to:
  /// **'country'**
  String get suggestion_country;

  /// No description provided for @suggestion_no_areas_found.
  ///
  /// In en, this message translates to:
  /// **'No areas found'**
  String get suggestion_no_areas_found;

  /// No description provided for @suggestion_select_category_title.
  ///
  /// In en, this message translates to:
  /// **'Select a Category for Recipes'**
  String get suggestion_select_category_title;

  /// No description provided for @suggestion_select_country_title.
  ///
  /// In en, this message translates to:
  /// **'Select a Country for Recipes'**
  String get suggestion_select_country_title;

  /// No description provided for @val_email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get val_email_invalid;

  /// No description provided for @val_email_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get val_email_required;

  /// No description provided for @val_name_required.
  ///
  /// In en, this message translates to:
  /// **'Full Name is required'**
  String get val_name_required;

  /// No description provided for @val_password_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get val_password_required;

  /// No description provided for @val_password_short.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {length} characters'**
  String val_password_short(int length);

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome {name}'**
  String welcome(String name);

  /// No description provided for @welcome_discover_recipes.
  ///
  /// In en, this message translates to:
  /// **'Discover delicious recipes and cooking tips from around the world.'**
  String get welcome_discover_recipes;

  /// No description provided for @welcome_get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get welcome_get_started;

  /// No description provided for @welcome_lorem_ipsum.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adip happy to see you but you\'r'**
  String get welcome_lorem_ipsum;

  /// No description provided for @welcome_slide1_part1.
  ///
  /// In en, this message translates to:
  /// **'Save and Organize '**
  String get welcome_slide1_part1;

  /// No description provided for @welcome_slide1_part2.
  ///
  /// In en, this message translates to:
  /// **'Your Best Recipes.'**
  String get welcome_slide1_part2;

  /// No description provided for @welcome_slide2_part1.
  ///
  /// In en, this message translates to:
  /// **'Explore a '**
  String get welcome_slide2_part1;

  /// No description provided for @welcome_slide2_part2.
  ///
  /// In en, this message translates to:
  /// **'World of '**
  String get welcome_slide2_part2;

  /// No description provided for @welcome_slide2_part3.
  ///
  /// In en, this message translates to:
  /// **'Culinary '**
  String get welcome_slide2_part3;

  /// No description provided for @welcome_slide2_part4.
  ///
  /// In en, this message translates to:
  /// **'Delights'**
  String get welcome_slide2_part4;

  /// No description provided for @welcome_slide3_part1.
  ///
  /// In en, this message translates to:
  /// **'Interactive Cooking : '**
  String get welcome_slide3_part1;

  /// No description provided for @welcome_slide3_part2.
  ///
  /// In en, this message translates to:
  /// **'Join the Chef in real time.'**
  String get welcome_slide3_part2;

  /// No description provided for @welcome_your_recipe_heaven_part1.
  ///
  /// In en, this message translates to:
  /// **'Your '**
  String get welcome_your_recipe_heaven_part1;

  /// No description provided for @welcome_your_recipe_heaven_part2.
  ///
  /// In en, this message translates to:
  /// **'Recipe Heaven'**
  String get welcome_your_recipe_heaven_part2;

  /// No description provided for @welcome_your_recipe_heaven_part3.
  ///
  /// In en, this message translates to:
  /// **'\nAwaits Exploration!'**
  String get welcome_your_recipe_heaven_part3;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ta': return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
