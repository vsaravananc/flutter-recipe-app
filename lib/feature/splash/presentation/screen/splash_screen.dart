import 'package:flutter/material.dart';
import 'package:recipe/feature/splash/presentation/widget/splash_logo_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child:  SplashLogoWidget(key: ValueKey('splash_logo_holder'),),),
    );
  }
}
