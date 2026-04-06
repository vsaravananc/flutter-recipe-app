import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/feature/home/domain/entities/home_category_entities.dart';
import 'package:recipe/feature/home/presentation/bloc/home_category_bloc/homecategory_bloc.dart';
import 'package:recipe/feature/home/presentation/bloc/home_recipe_bloc/recipe_bloc.dart';
import 'package:recipe/feature/home/presentation/widget/home_category_placeholder_widget.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomecategoryBloc, HomecategoryState>(
      builder: (context, state) {
        if (state is HomecategoryInitial ||
            state is HomecategoryLoading ||
            state is HomecategoryError) {
          return const CategoryPlaceHolderWidget(
            key: ValueKey("category_placeholder_widget"),
          );
        } else {
          final result = state as HomecategoryLoaded;
          return SliverPadding(
            padding: const EdgeInsets.only(bottom: Dimensions.p4),
            sliver: CategoryDisplayWidget(
              key: const ValueKey("category_display_widget"),
              result: result,
            ),
          );
        }
      },
    );
  }
}

/// Placeholder widget for loading and error states
class CategoryPlaceHolderWidget extends StatelessWidget {
  const CategoryPlaceHolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          padding: const .only(left: Dimensions.p8),
          itemBuilder: (c, i) => Column(
            mainAxisAlignment: .center,
            children: [
              Container(
                margin: const .symmetric(horizontal: 5.0),
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: context.secondary,
                  borderRadius: .circular(35),
                ),
              ),
            ],
          ),
          itemCount: 5,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

/// Widget for displaying individual category items
class CategoryDisplayWidget extends StatefulWidget {
  final HomecategoryLoaded result;
  const CategoryDisplayWidget({super.key, required this.result});

  @override
  State<CategoryDisplayWidget> createState() => _CategoryDisplayWidgetState();
}

class _CategoryDisplayWidgetState extends State<CategoryDisplayWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110,
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          controller: scrollController,
          padding: const .only(left: Dimensions.p4),
          shrinkWrap: true,
          itemCount: widget.result.categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final category = widget.result.categories[index];
            return IndividualCategoryItem(
              category: category,
              scrollController: scrollController,
              index: index,
              key: ValueKey(index),
            );
          },
        ),
      ).animate().fadeIn(duration: const Duration(milliseconds: 450)).slideY(
            begin: 0.1,
            end: 0,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 450),
          ),
    );
  }
}

/// Widget for individual category item
class IndividualCategoryItem extends StatelessWidget {
  final HomeCategoryEntities category;
  final ScrollController scrollController;
  final int index;
  const IndividualCategoryItem({
    super.key,
    required this.category,
    required this.scrollController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomecategoryBloc, HomecategoryState>(
      builder: (context, selectedCategory) {
        final HomeCategoryEntities selected =
            (selectedCategory as HomecategoryLoaded).selectedCategories;
        return GestureDetector(
          onTap: () {
            if (selected != category) _selectData(context);
            if (index < 2) return;
            final double itemWidth =
                (context.findRenderObject() as RenderBox).size.width;
            final double screenWidth = MediaQuery.of(context).size.width;

            final double position =
                (itemWidth * index) + (itemWidth / 2) - (screenWidth / 2);
            scrollController.animateTo(
              position,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
            );
          },
          child: Padding(
            padding: const .symmetric(horizontal: 8, vertical: 8),
            child: Column(
              spacing: 5,
              children: [
                CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(35),
                      color: category == selected
                          ? context.primary
                          : context.tertiary,
                    ),
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: context.transprent,
                        borderRadius: BorderRadiusGeometry.circular(30),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => 
                      const HomeCategoryPlaceholderWidget(
                        key: ValueKey("placeholder_homecategory_placeholder"),
                      ),

                  errorWidget: (context, url, error) =>
                      const HomeCategoryPlaceholderWidget(
                        key: ValueKey("error_homecategory_placeholder"),
                      ),

                  imageUrl: category.imageUrl,
                  fit: BoxFit.cover,
                ),
                Text(category.name, style: context.bodyMedium),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectData(BuildContext context) {
    context.read<HomecategoryBloc>().add(
      SelectHomeCategori(homeCategoryEntities: category),
    );
    context.read<HomeRecipeBloc>().add(
      GetRecipeEvent(categoryName: category.name),
    );
  }
}

/// placeholder and progressindicator widget
class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: context.cardColor,
      ),
      child: const SizedBox(width: 55, height: 55),
    );
  }
}
