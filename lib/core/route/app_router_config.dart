import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/feature/auth/presentation/screens/auth_screen.dart';
import 'package:recipe/feature/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:recipe/feature/details/domain/entities/detail_screenl_entitie.dart';
import 'package:recipe/feature/details/presentation/screens/detail_screen.dart';
import 'package:recipe/feature/profile/presentation/screen/profile_screen.dart';
import 'package:recipe/feature/search/presentation/screen/search_screen.dart';
import 'package:recipe/feature/splash/presentation/screen/splash_screen.dart';
import 'package:recipe/feature/user_sugestion/presentation/screen/select_area_screen.dart';
import 'package:recipe/feature/user_sugestion/presentation/screen/select_category_screen.dart';
import 'package:recipe/feature/welcome/presentation/screens/get_started_screen.dart';
import 'package:recipe/feature/welcome/presentation/screens/welcome_screen.dart';

class AppRouterConfig {
  ///  routes of the app
  static const String initialRoute = '/';
  static const String getStarted = '${initialRoute}getStarted';
  static const String welcomeRoute = '$initialRoute/welcome';
  static const String authRoute = '$welcomeRoute/auth';
  static const String areaRoute = '$authRoute/userprefrence/area';
  static const String categoryRoute = '$areaRoute/userprefrence/category';
  static const String dashBoardRoute = "${initialRoute}logedin/dashboard";
  static const String detailsRoute = '$dashBoardRoute/details';
  static const String searchRoute = '$dashBoardRoute/Search';
  static const String profileRoute = '$dashBoardRoute/profile';

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
        path: getStarted,
        name: getStarted,
        builder: (context, state) =>
            const GetStartedScreen(key: ValueKey("get_started_screen")),
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
      GoRoute(
        path: detailsRoute,
        name: 'detail_screen',
        builder: (context, state) {
          DetailScreenlEntitie detail = state.extra as DetailScreenlEntitie;
          return DetailScreen(foodDetail: detail, key: ValueKey(detail.id));
        },
      ),
      GoRoute(
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SearchScreen(key: ValueKey('search_screen')),
            opaque: false,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  Animation<Offset> position =
                      Tween<Offset>(
                        begin: const Offset(0, -1),
                        end: const Offset(0, 0),
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeIn,
                        ),
                      );
                  return SlideTransition(position: position, child: child);
                },
          );
        },
        path: searchRoute,
        name: 'search_route',
        builder: (context, state) {
          return const SearchScreen(key: ValueKey('search_screen'));
        },
      ),
      GoRoute(
        path: profileRoute,
        name: 'profile_screen',
        builder: (context, state) {
          return const ProfileScreen(key: ValueKey('profile_screen'));
        },
      ),
    ],
    ///! here i have changed the initalLocation route to dashBoardRoute for development purpose.
    ///! you can change it back to initialRoute when needed.
    ///! actually it should be initialRoute
    initialLocation: initialRoute,
  );
}
