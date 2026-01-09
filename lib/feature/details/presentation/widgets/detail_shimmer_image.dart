import 'package:flutter/material.dart';
import 'package:recipe/core/services/dimensions.dart';

class DetailShimmerImage extends StatelessWidget {
  const DetailShimmerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: .circular(Dimensions.p24),
        color: Theme.of(context).cardColor,
      ),
    );
  }
}
