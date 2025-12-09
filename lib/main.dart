import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/core/services/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DependencyInjection.init();
  runApp(DependencyInjection.intialize(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: FlexThemeData.light(scheme: FlexScheme.mango),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.mango,
        subThemesData: const FlexSubThemesData(
          interactionEffects: true,
          tintedDisabledControls: true,
          blendOnColors: true,
          useM2StyleDividerInM3: true,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorContentPadding: EdgeInsetsDirectional.fromSTEB(
            12,
            16,
            12,
            12,
          ),
          inputDecoratorBackgroundAlpha: 40,
          inputDecoratorBorderSchemeColor: SchemeColor.primary,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          inputDecoratorRadius: 8.0,
          inputDecoratorUnfocusedBorderIsColored: false,
          inputDecoratorBorderWidth: 1.0,
          inputDecoratorFocusedBorderWidth: 2.0,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.primaryFixed,
          inputDecoratorSuffixIconSchemeColor: SchemeColor.primary,
          alignedDropdown: true,
          navigationRailUseIndicator: true,
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: "Recipe-book",
      routerConfig: AppRouterConfig.router,
    );
  }
}
