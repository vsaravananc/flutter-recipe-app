// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appName => 'ALL-IN-ONE';

  @override
  String get login => 'உள்நுழை';

  @override
  String get logout => 'வெளியேறு';

  @override
  String get home => 'முகப்பு';

  @override
  String get settings => 'அமைப்புகள்';

  @override
  String welcome(String name) {
    return 'வரவேற்கிறோம் $name';
  }
}
