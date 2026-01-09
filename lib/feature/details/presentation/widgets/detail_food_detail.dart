import 'package:flutter/cupertino.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';

class DetailFoodDetail extends StatelessWidget {
  final String foodName;
  const DetailFoodDetail({super.key, required this.foodName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: .min,
        children: [
          Text(
            foodName,
            maxLines: 1,
            overflow: .clip,
            style: context.titleLarge?.copyWith(fontWeight: .bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
