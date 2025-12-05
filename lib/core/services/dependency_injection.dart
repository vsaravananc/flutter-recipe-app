import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/feature/welcome/presentation/cubit/pagecurrentindex_cubit.dart';

class DependencyInjection {
  static Widget intialize(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PagecurrentindexCubit>(
          create: (context) => PagecurrentindexCubit(),
        ),
      ],
      child: child,
    );
  }
}
