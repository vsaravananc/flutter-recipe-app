import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/core/services/beral_container.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/feature/details/domain/entities/detail_screenl_entitie.dart';
import 'package:recipe/feature/search/domain/entities/search_entities.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchResult) {
          return SliverPadding(
            padding: const .fromLTRB(12, 12, 12, 20),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: state.searchResult.length,
              itemBuilder: (context, i) =>
                  ImagePlaceHolderWidget(recipe: state.searchResult[i]),
            ),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}

/// Image placeholder widget
class ImagePlaceHolderWidget extends StatelessWidget {
  final SearchRecipeEntities recipe;
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
