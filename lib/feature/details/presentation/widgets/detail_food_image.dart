import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/feature/details/presentation/widgets/shimmer/detail_shimmer_image.dart';

class DetailFoodImage extends StatelessWidget {
  final String imageUrl;
  const DetailFoodImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 5, vertical: 5),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageprovider) => Container(
              height: MediaQuery.sizeOf(context).height / 2,
              decoration: BoxDecoration(
                image: DecorationImage(image: imageprovider, fit: BoxFit.cover),
                borderRadius:  .only(
                  topLeft: .circular( Platform.isIOS ? Dimensions.p48 : Dimensions.p32),
                  topRight: .circular(Platform.isIOS ? Dimensions.p48 : Dimensions.p32),
                  bottomLeft: const .circular(Dimensions.p24),
                  bottomRight: const .circular(Dimensions.p24),
                ),
              ),
            ),
            errorWidget: (context, url, error) =>
                const DetailShimmerImage(key: ValueKey("error_widget")),
            placeholder: (context, url) =>
                const DetailShimmerImage(key: ValueKey("place_holder_widget")),
          ),
          const DetailBackButton(key: ValueKey("back_position_button")),
        ],
      ),
    );
  }
}

class DetailBackButton extends StatelessWidget {
  const DetailBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: const ValueKey("position_back_icon"),
      left: 10,
      child: SafeArea(
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: .circular(100)),
          color: Theme.of(context).cardColor,
          child: InkWell(
            splashColor: Theme.of(context).primaryColor.withValues(alpha: .8),
            onTap: () => context.pop(),
            child: const Padding(
              padding: .all(8.0),
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
