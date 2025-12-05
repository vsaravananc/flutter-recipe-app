import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/feature/welcome/presentation/cubit/pagecurrentindex_cubit.dart';

class WelcomeFloatingWidget extends StatelessWidget {
  final PageController controller;
  const WelcomeFloatingWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagecurrentindexCubit, int>(
      builder: (context, state) => FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: state == 2
            ? () {
                context.pushReplacement(AppRouterConfig.authRoute);
              }
            : () {
                controller.animateToPage(
                  state + 1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
