import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/feature/auth/presentation/bloc/auth_ui_bloc/auth_ui_bloc.dart';
import 'package:recipe/feature/auth/presentation/screens/auth_login_screen.dart';
import 'package:recipe/feature/auth/presentation/screens/auth_signup_screen.dart';
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
            spacing: 30,
            children: [AuthLogoHolderWidget(), AuthScreenAnimationHolder()],
          ),
        ),
      ),
    );
  }
}

///
/// AUTH SCREEN ANIMTION HOLDER BELOW CODE IMPLEMENT FOR ANIMTION PURPOSE
///

class AuthScreenAnimationHolder extends StatefulWidget {
  const AuthScreenAnimationHolder({super.key});

  @override
  State<AuthScreenAnimationHolder> createState() =>
      _AuthScreenAnimationHolderState();
}

class _AuthScreenAnimationHolderState extends State<AuthScreenAnimationHolder>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> position;
  @override
  void initState() {
    super.initState();
    initalizeAnimation();
  }

  void initalizeAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    position = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
        .animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
          ),
        );

    Future.delayed(const Duration(milliseconds: 300), controller.forward);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthUIBloc, AuthUIState>(
      builder: (context, state) {
        return SlideTransition(
          position: position,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.all(15),
            child: state is AuthLogin
                ? const AuthLoginInScreen(key: ValueKey('auth_login_holder'))
                : const AuthSignUpScreen(key: ValueKey('auth_signup_holder')),
          ),
        );
      },
    );
  }
}
