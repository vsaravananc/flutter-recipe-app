// import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/core/services/dependency_injection.dart';
import 'package:recipe/core/theme/theme_extenstion/gradint_theme_extenstion.dart';
import 'package:recipe/core/util/app_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  await sl.allReady();
  runApp(DependencyInjection.intialize(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        return MediaQuery.withNoTextScaling(child: child!);
      },
      theme: FlexThemeData.light(
        scheme: FlexScheme.mango,
        fontFamily: AppFonts.inter,
        extensions: [
          GradintThemeExtenstion(
            colors: [
              context.transprent,
              context.shadowColor.withValues(alpha: 0.1),
              context.shadowColor.withValues(alpha: 0.8),
            ],
          ),
        ],
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.mango,
        fontFamily: AppFonts.inter,
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
        extensions: [
          GradintThemeExtenstion(
            colors: [
              context.transprent,
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.8),
            ],
          ),
        ],
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: "Recipe-book",
      
      routerConfig: AppRouterConfig.router,
    );
  }
}
