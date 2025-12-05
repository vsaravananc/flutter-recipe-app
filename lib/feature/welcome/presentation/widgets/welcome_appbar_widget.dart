import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/feature/welcome/presentation/cubit/pagecurrentindex_cubit.dart';

class WelcomeAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final PageController controller;
  const WelcomeAppbarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagecurrentindexCubit, int>(
      builder: (context, state) {
        return AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Recipe Book",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            WelcomeAppSkipButton(
              key: const ValueKey('welcome_skip_button'),
              visible: state < 2,
              onPressed: () => controller.animateToPage(
                2,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class WelcomeAppSkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool visible;
  const WelcomeAppSkipButton({
    super.key,
    required this.onPressed,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: visible
          ? TextButton(
              onPressed: onPressed,
              child: Text(
                "skip",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          : const SizedBox.shrink(),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      ),
    );
  }
}
