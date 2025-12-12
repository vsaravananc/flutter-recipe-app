import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/feature/auth/presentation/screens/auth_screen.dart';
import 'package:recipe/feature/splash/presentation/screen/splash_screen.dart';
import 'package:recipe/feature/user_sugestion/presentation/screen/select_area_screen.dart';
import 'package:recipe/feature/welcome/presentation/screens/welcome_screen.dart';

class AppRouterConfig {
  ///  routes of the app
  static const String initialRoute = '/';
  static const String welcomeRoute = '/welcome';
  static const String authRoute = '$welcomeRoute/auth';
  static const String areaRoute = '$authRoute/area';

  /// gorouter config of the app
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: initialRoute,
        name: initialRoute,
        builder: (context, state) =>
            const SplashScreen(key: ValueKey("Splash_screen")),
      ),
      GoRoute(
        path: welcomeRoute,
        name: welcomeRoute,
        builder: (context, state) =>
            const WelcomeScreen(key: ValueKey("welcome_screen")),
      ),
      GoRoute(
        path: authRoute,
        name: authRoute,
        builder: (context, state) =>
            const AuthScreen(key: ValueKey("auth_screen")),
      ),
      GoRoute(
        path: areaRoute,
        name: areaRoute,
        builder: (context, state) =>
            const SelectAreaScreen(key: ValueKey("select_area_screen")),
      ),
    ],
    initialLocation: initialRoute,
  );
}
