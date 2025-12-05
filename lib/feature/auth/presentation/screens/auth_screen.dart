import 'package:flutter/material.dart';
import 'package:recipe/feature/auth/presentation/screens/auth_login_screen.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_logo_holder_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            spacing: 30 ,
            children: [
              AuthLogoHolderWidget(),
              AuthLoginInScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
