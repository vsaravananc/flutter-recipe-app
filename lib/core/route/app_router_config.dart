import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/feature/auth/presentation/screens/auth_screen.dart';
import 'package:recipe/feature/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:recipe/feature/splash/presentation/screen/splash_screen.dart';
import 'package:recipe/feature/user_sugestion/presentation/screen/select_area_screen.dart';
import 'package:recipe/feature/user_sugestion/presentation/screen/select_category_screen.dart';
import 'package:recipe/feature/welcome/presentation/screens/welcome_screen.dart';

class AppRouterConfig {
  ///  routes of the app
  static const String initialRoute = '/';
  static const String welcomeRoute = '${initialRoute}welcome';
  static const String authRoute = '$welcomeRoute/auth';
  static const String areaRoute = '$authRoute/userprefrence/area';
  static const String categoryRoute = '$areaRoute/userprefrence/category';
  static const String dashBoardRoute = "${initialRoute}logedin/dashboard";

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
      GoRoute(
        path: categoryRoute,
        name: categoryRoute,
        builder: (context, state) =>
            const SelectCategoryScreen(key: ValueKey("select_category_screen")),
      ),
      GoRoute(
        path: dashBoardRoute,
        name: dashBoardRoute,
        builder: (context, state) =>
            const DashboardScreen(key: ValueKey("dash_doard_screen")),
      ),
    ],
    ///! here i have changed the initalLocation route to dashBoardRoute for development purpose.
    ///! you can change it back to initialRoute when needed.
    ///! actually it should be initialRoute
    initialLocation: initialRoute,
  );
}
