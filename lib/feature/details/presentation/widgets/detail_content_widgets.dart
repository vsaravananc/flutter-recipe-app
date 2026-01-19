
import 'package:flutter/material.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/feature/details/domain/entities/detail_entite.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IngredientWidget extends StatelessWidget {
  final List<MealIntegration> mealIntegrationCollection;
  final List<MealMeasure> mealMeasureCollection;
  const IngredientWidget({
    super.key,
    required this.mealIntegrationCollection,
    required this.mealMeasureCollection,
  });

  @override
  Widget build(BuildContext context) {
    int length = mealIntegrationCollection.length > mealMeasureCollection.length
        ? mealIntegrationCollection.length
        : mealMeasureCollection.length;
    return Column(
      crossAxisAlignment: .start,
      spacing: 5,
      children: [
        Text("Ingredients", style: heading(context)),
        ListView.builder(
          padding: const .only(left: 5, top: 0),
          itemBuilder: (c, i) {
            return Row(
              spacing: 8,
              crossAxisAlignment: .center,
              children: [
                const CircleAvatar(radius: 5),
                Expanded(
                  child: RichText(
                    maxLines: 1,
                    overflow: .ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${mealMeasureCollection[i].measure} ",
                          style: context.titleMedium?.copyWith(fontWeight: .bold),
                        ),
                        TextSpan(
                          text: "(${mealIntegrationCollection[i].integration}) ",
                          style: context.bodyLarge,
                          
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }

  TextStyle heading(BuildContext context) =>
      context.titleLarge!.copyWith(fontWeight: .bold);
}

class YoutubePlayerWidget extends StatefulWidget {
  final String initialVideoId;
  final String thumbnail;
  const YoutubePlayerWidget({
    super.key,
    required this.initialVideoId,
    required this.thumbnail,
  });

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    final videoID = widget.initialVideoId.split('watch?v=').last;
    controller = YoutubePlayerController(
      initialVideoId: videoID,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        useHybridComposition: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(bottom: MediaQuery.viewPaddingOf(context).bottom),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: YoutubePlayer(
          width: .infinity,
          controller: controller,
        ),
      ),
    );
  }
}
