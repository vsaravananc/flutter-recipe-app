import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/core/extensions/localization_extension.dart';
import 'package:recipe/feature/details/domain/entities/detail_screenl_entitie.dart';
import 'package:recipe/feature/details/presentation/bloc/detail_bloc.dart';
import 'package:recipe/feature/home/domain/entities/home_recipe_entities.dart';
import 'package:recipe/feature/home/presentation/bloc/home_recipe_bloc/recipe_bloc.dart';
import 'package:recipe/feature/home/presentation/widget/home_recipe_placeholder_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
                  child: Text(context.l10n.home_recipes_title, style: context.headlineSmall),
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
        onTap: () {
          context.read<DetailBloc>().add(JustChangeState());
          DetailScreenlEntitie detail = DetailScreenlEntitie(
            id: recipe.id,
            title: recipe.name,
            titleTag: "recipe_title${recipe.id}",
            image: recipe.imageUrl,
            imageTag: "recipe_image${recipe.id}",
          );
          context.push(AppRouterConfig.detailsRoute, extra: detail);
        },
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
                  transitionOnUserGestures: true,
                  child: Material(
                    color: context.transprent,
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
            ),
          ],
        ),
      ).animate().fadeIn(duration: const Duration(milliseconds: 450)).slideY(
            begin: 0.1,
            end: 0,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 450),
          ),
      placeholder: (context, _) => const HomeRecipePlaceholderWidget(
        key: ValueKey("placeholder_recipe_placeHolder_widget"),
      ),

      errorWidget: (context, url, error) => const HomeRecipePlaceholderWidget(
        key: ValueKey("error_recipe_placeHolder_widget"),
      ),
    );
  }
}
