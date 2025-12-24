import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/feature/home/domain/entities/home_category_entities.dart';
import 'package:recipe/feature/home/presentation/bloc/home_category_bloc/homecategory_bloc.dart';

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
class CategoryDisplayWidget extends StatelessWidget {
  final HomecategoryLoaded result;
  const CategoryDisplayWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: 110,
          child: ListView.builder(
            padding: const .only(left: Dimensions.p4),
            shrinkWrap: true,
            itemCount: result.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = result.categories[index];
              return IndividualCategoryItem(
                category: category,
                key: ValueKey(category.id),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Widget for individual category item
class IndividualCategoryItem extends StatelessWidget {
  final HomeCategoryEntities category;
  const IndividualCategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 8, vertical: 8),
      child: Column(
        spacing: 5,
        children: [
          CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(35),
                color: context.tertiary,
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
            imageUrl: category.imageUrl,
            fit: BoxFit.cover,
          ),
          Text(category.name, style: context.bodyMedium),
        ],
      ),
    );
  }
}
