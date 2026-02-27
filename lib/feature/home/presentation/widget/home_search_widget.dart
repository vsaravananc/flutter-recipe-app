import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/core/services/beral_container.dart';
import 'package:recipe/core/services/dimensions.dart';

class HomeSearchWidget extends SliverPersistentHeader {
  final ScrollController scrollController;
  HomeSearchWidget({super.key, required this.scrollController})
    : super(delegate: HomeSearchDelegate(scrollController), pinned: true);
}

class HomeSearchDelegate extends SliverPersistentHeaderDelegate {
  final ScrollController scrollController;
  const HomeSearchDelegate(this.scrollController);
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double elevationProgress = (shrinkOffset / maxExtent).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: () {
        context.read<SearchBloc>().add(TriggerInitalEvent());
        scrollController.animateTo(
          250,
          duration: const Duration(milliseconds: 380),
          curve: Curves.easeIn,
        );
        context.push(AppRouterConfig.searchRoute);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.p12,
          vertical: Dimensions.p10,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.20 * elevationProgress),
              blurRadius: 8 * elevationProgress,
              spreadRadius: 1 * elevationProgress,
              offset: const Offset(0, 2),
            ),
          ],
          color: context.scaffoldBackgroundColor,
        ),
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
