import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/feature/home/domain/entities/home_category_entities.dart';
import 'package:recipe/feature/home/presentation/bloc/home_category_bloc/homecategory_bloc.dart';
import 'package:recipe/feature/home/presentation/bloc/home_recipe_bloc/recipe_bloc.dart';
import 'package:recipe/feature/home/presentation/widget/home_category_widget.dart';
import 'package:recipe/feature/home/presentation/widget/home_header_widget.dart';
import 'package:recipe/feature/home/presentation/widget/home_recipe_widget.dart';
import 'package:recipe/feature/home/presentation/widget/home_search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initFirstCall();
  }

  void _initFirstCall() {
    if (context.read<HomecategoryBloc>().state is HomecategoryLoaded) {
      final HomeCategoryEntities categoryEntities =
          (context.read<HomecategoryBloc>().state as HomecategoryLoaded)
              .selectedCategories;
      context.read<HomeRecipeBloc>().add(
        GetRecipeEvent(categoryName: categoryEntities.name),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeHeaderWidget(key: ValueKey("home_header_widget")),
            HomeSearchWidget(key: ValueKey("home_search_widget")),
            HomeCategoryWidget(key: ValueKey("home_category_widget")),
            HomeRecipeWidget(key: ValueKey("home_recipe_widget")),
          ],
        ),
      ),
    );
  }
}
