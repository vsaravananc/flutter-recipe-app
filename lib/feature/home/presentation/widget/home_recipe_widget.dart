import 'package:flutter/material.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/services/dimensions.dart';

class HomeRecipeWidget extends StatelessWidget {
  const HomeRecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const .symmetric(horizontal: Dimensions.p16),
      sliver: SliverMainAxisGroup(
        key: const ValueKey("home_recipe_sliver_main_axis_group"),
        slivers: [
          SliverToBoxAdapter(
            child: Text('Recipes', style: context.headlineMedium),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(title: Text('Recipe #$index')),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
