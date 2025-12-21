import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/services/dimensions.dart';

class HomeSearchWidget extends SliverPersistentHeader {
  HomeSearchWidget({super.key})
    : super(delegate: HomeSearchDelegate(), pinned: true);
}

class HomeSearchDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return GestureDetector(
      onTap: () {
        // Handle search tap
        debugPrint("Search tapped");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.p12,
          vertical: Dimensions.p10,
        ),
        color: context.scaffoldBackgroundColor,
        child: Container(
          padding: const EdgeInsets.only(
            left: Dimensions.p16,
            right: Dimensions.p4,
          ),
          height: double.infinity,
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(Dimensions.p32),
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                "Search any recipe",
                style: context.titleMedium?.copyWith(color: context.hintColor),
              ),
              CircleAvatar(
                radius: 23,
                backgroundColor: context.primaryContainer,
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  color: context.onPrimaryContainer,
                  strokeWidth: 2.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 75;

  @override
  double get minExtent => 75;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
