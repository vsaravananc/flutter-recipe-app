import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/feature/details/domain/entities/detail_entite.dart';
import 'package:recipe/feature/details/presentation/bloc/detail_bloc.dart';
import 'package:recipe/feature/details/presentation/widgets/detail_content_widgets.dart';
import 'package:recipe/feature/details/presentation/widgets/shimmer/detail_shimmer_food.dart';

class DetailFoodDetail extends StatelessWidget {
  const DetailFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 12),
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is! DetailHaveData) {
            return const DetailFoodShimmer(key: ValueKey("Detail_shimmer"));
          }
          return DetailFood(
            data: state.detailEntite,
            key: ValueKey('detail_food${state.detailEntite.mealAlternate}'),
          );
        },
      ),
    );
  }
}

class DetailFood extends StatelessWidget {
  final DetailEntite data;
  const DetailFood({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        Text(data.mealArea, style: subHeading(context)),
        IngredientWidget(
          key: ValueKey("ingredient_holder_widget${data.mealId}"),
          mealIntegrationCollection: data.mealIntegrationCollection,
          mealMeasureCollection: data.mealMeasureCollection,
        ),
        Text("Instructions", style: heading(context)),
        Text(data.mealInstruction, style: subHeading(context)),
        Text("Recipe Video", style: heading(context)),
        RepaintBoundary(
          key: const ValueKey("youtube_video_render"),
          child: YoutubePlayerWidget(
            key: ValueKey("yout_holder_widget_${data.mealId}"),
            initialVideoId: data.mealCookingVideo,
            thumbnail: data.mealThumbImage,
          ),
        ),
      ],
    );
  }

  TextStyle subHeading(BuildContext context) => context.bodyLarge!;
  TextStyle heading(BuildContext context) =>
      context.titleLarge!.copyWith(fontWeight: .bold);
}
