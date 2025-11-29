import 'package:flutter/material.dart';
import 'package:recipe/core/route/app_router_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Recipe-book",
      routerConfig: AppRouterConfig.router,
    );
  }
}
