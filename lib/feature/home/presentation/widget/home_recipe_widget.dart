import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe/core/extensions/color_extension.dart';
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
          SliverPadding(
            padding: const .only(bottom: Dimensions.p10),
            sliver: SliverToBoxAdapter(
              child: Text('Recipes', style: context.headlineMedium),
            ),
          ),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 10,
            itemBuilder: (context, i) => ImagePlaceHolderWidget(index: i),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

/// Image placeholder widget
class ImagePlaceHolderWidget extends StatelessWidget {
  final int index;
  const ImagePlaceHolderWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            ImageParllelScrolling(
              imageProvider: imageProvider,
              tag: "recipe_image$index",
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.p16),
                gradient: LinearGradient(
                  colors: context.gradint,
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.9),
              child: Hero(
                tag: "recipe_title$index",
                child: Text(
                  "Burger",
                  style: context.titleLarge?.copyWith(
                    color: context.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// image for parllel scrolling
class ImageParllelScrolling extends StatelessWidget {
  final ImageProvider imageProvider;
  final String tag;
  const ImageParllelScrolling({
    super.key,
    required this.imageProvider,
    required this.tag,
  });


  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(Dimensions.p16),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
