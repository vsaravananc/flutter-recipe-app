import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/feature/welcome/presentation/cubit/pagecurrentindex_cubit.dart';
import 'package:recipe/feature/welcome/presentation/screens/sub_screens/welcome_one.dart';
import 'package:recipe/feature/welcome/presentation/screens/sub_screens/welcome_three.dart';
import 'package:recipe/feature/welcome/presentation/screens/sub_screens/welcome_two.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_appbar_widget.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_dot_widget.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_floating_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WelcomeAppbarWidget(
        controller: pageController,
        key: const ValueKey('welcome_appbar_holder'),
      ),
      body: SafeArea(
        child: WelcomeDotsHolder(
          key: const ValueKey('welcome_screen_holder'),
          child: WelcomeOnboardingScreens(
            controller: pageController,
            key: const ValueKey("welcome-onboarding-screens"),
          ),
        ),
      ),
      floatingActionButton: WelcomeFloatingWidget(
        controller: pageController,
        key: const ValueKey('welcome_floating_holder'),
      ),
    );
  }
}

/// welcome dots holder class
class WelcomeDotsHolder extends StatelessWidget {
  final Widget child;
  const WelcomeDotsHolder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const Positioned(
          left: 0,
          right: 0,
          bottom: kBottomNavigationBarHeight * 3.5,
          child: WelcomeDotWidget(key: ValueKey('welcome_dots_holder')),
        ),
      ],
    );
  }
}

/// wlecome onboarding screens

class WelcomeOnboardingScreens extends StatefulWidget {
  final PageController controller;
  const WelcomeOnboardingScreens({super.key, required this.controller});

  @override
  State<WelcomeOnboardingScreens> createState() =>
      _WelcomeOnboardingScreensState();
}

class _WelcomeOnboardingScreensState extends State<WelcomeOnboardingScreens> {
  List<Widget> widgets = const [
    WelcomeOne(key: ValueKey('welcome_one')),
    WelcomeTwo(key: ValueKey('welcome_two')),
    WelcomeThree(key: ValueKey('welcome_three')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagecurrentindexCubit, int>(
      builder: (context, state) {
        return PageView.builder(
          controller: widget.controller,
          onPageChanged: (index) =>
              context.read<PagecurrentindexCubit>().setIndex(index),
          itemBuilder: (context, index) => widgets[index],
          itemCount: widgets.length,
          allowImplicitScrolling: true,
          scrollDirection: .horizontal,
          clipBehavior: Clip.none,
          key: const ValueKey('welcome_screens_holders'),
        );
      },
    );
  }
}
