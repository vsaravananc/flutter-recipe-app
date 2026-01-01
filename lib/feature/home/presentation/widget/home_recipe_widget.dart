import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/feature/home/domain/entities/home_recipe_entities.dart';
import 'package:recipe/feature/home/presentation/bloc/home_recipe_bloc/recipe_bloc.dart';

class HomeRecipeWidget extends StatelessWidget {
  const HomeRecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeRecipeBloc, RecipeState>(
      builder: (context, state) {
        return SliverPadding(
          padding: const .symmetric(horizontal: Dimensions.p16),
          sliver: SliverMainAxisGroup(
            key: const ValueKey("home_recipe_sliver_main_axis_group"),
            slivers: [
              SliverPadding(
                padding: const .only(bottom: Dimensions.p10),
                sliver: SliverToBoxAdapter(
                  child: Text('Recipes', style: context.headlineMedium),
                ),
              ),
              if (state is RecipeLoaded)
                SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.recipeList.length,
                  itemBuilder: (context, i) =>
                      ImagePlaceHolderWidget(recipe: state.recipeList[i]),
                )
              else
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const .only(top: 20),
                    child: CupertinoActivityIndicator(
                      color: context.primary,
                      radius: 16,
                    ),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        );
      },
    );
  }
}

/// Image placeholder widget
class ImagePlaceHolderWidget extends StatelessWidget {
  final HomeRecipeEntities recipe;
  const ImagePlaceHolderWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: recipe.imageUrl,
      fit: .cover,
      imageBuilder: (context, imageProvider) => GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            Hero(
              tag: "recipe_image${recipe.id}",
              child: Container(
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: .circular(Dimensions.p16),
                  image: DecorationImage(image: imageProvider, fit: .cover),
                ),
                child: Container(
                  height: .infinity,
                  width: .infinity,
                  decoration: BoxDecoration(
                    borderRadius: .circular(Dimensions.p16),
                    gradient: LinearGradient(
                      colors: context.gradint,
                      begin: .topCenter,
                      end: .bottomCenter,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const .symmetric(horizontal: 4),
              child: Align(
                alignment: const Alignment(0.0, 0.9),
                child: Hero(
                  tag: "recipe_title${recipe.id}",
                  child: Text(
                    recipe.name,
                    maxLines: 1,
                    style: context.titleLarge?.copyWith(
                      color: context.onPrimary,
                      fontWeight: .bold,
                    ),
                    textAlign: .center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      placeholder: (context, _) => Container(
        decoration: BoxDecoration(
          borderRadius: .circular(Dimensions.p16),
          color: context.cardColor,
        ),
      ),
    );
  }
}
