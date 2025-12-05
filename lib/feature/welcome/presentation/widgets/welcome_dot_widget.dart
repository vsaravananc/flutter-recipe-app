import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/feature/welcome/presentation/cubit/pagecurrentindex_cubit.dart';

class WelcomeDotWidget extends StatelessWidget {
  const WelcomeDotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagecurrentindexCubit, int>(
      builder: (context, state) {
        return Row(
          spacing: 8,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: List.generate(
            3,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 8,
              width: state == i ? 20 : 8,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        );
      },
    );
  }
}
