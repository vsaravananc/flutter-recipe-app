import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/feature/home/presentation/bloc/home_category_bloc/homecategory_bloc.dart';
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
    getData();
  }

  void getData() {
    if (mounted &&
            context.read<HomecategoryBloc>().state is HomecategoryInitial ||
        context.read<HomecategoryBloc>().state is HomecategoryError) {
      context.read<HomecategoryBloc>().add(FetchHomeCategories());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const HomeHeaderWidget(key: ValueKey("home_header_widget")),
            HomeSearchWidget(key: const ValueKey("home_search_widget")),
            const HomeCategoryWidget(key: ValueKey("home_category_widget")),
            const HomeRecipeWidget(key: ValueKey("home_recipe_widget")),
          ],
        ),
      ),
    );
  }
}
