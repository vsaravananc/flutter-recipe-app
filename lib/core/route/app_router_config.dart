import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/feature/splash/presentation/screen/splash_screen.dart';

class AppRouterConfig {
  static const String initialRoute = '/';
  static final RouteBase initialRouteBase = GoRoute(
    path: initialRoute,
    name: "splash",
    builder: (context, state) =>
        const SplashScreen(key: ValueKey("Splash_screen")),
  );
  static GoRouter router = GoRouter(routes: [initialRouteBase]);
}
