import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/feature/profile/presentation/bloc/profile_bloc.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      key: ValueKey("home_header_widget"),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Dimensions.p16,
          Dimensions.p8,
          Dimensions.p16,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HeaderTopBar(key: ValueKey("header_top_bar")),
            SizedBox(height: Dimensions.p10),
            // GreetingText(key: ValueKey("greeting_text")),
            // SizedBox(height: Dimensions.p4),
            HeaderDescription(key: ValueKey("header_description")),

            SizedBox(height: Dimensions.p10),
          ],
        ),
      ),
    );
  }
}

/// Header Top Bar Widget
class HeaderTopBar extends StatelessWidget {
  const HeaderTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.push(AppRouterConfig.profileRoute);
          },
          child: Hero(
            tag: 'profile_avatar',
            child: CircleAvatar(
              radius: 18,
              child: Image.asset(context.watch<ProfileBloc>().state.profileEntitie.image),
            ),
          ),
        ),
        // const HugeIcon(icon: HugeIcons.strokeRoundedNotification01, size: 30),
      ],
    );
  }
}

/// Greeting Text Widget
class GreetingText extends StatelessWidget {
  const GreetingText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: 'Hello,', style: context.titleMedium),
          TextSpan(
            text: ' John Doe!',
            style: context.titleMedium?.copyWith(color: context.primary),
          ),
        ],
      ),
    );
  }
}

/// Header Description Widget
class HeaderDescription extends StatelessWidget {
  const HeaderDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      strutStyle: const StrutStyle(forceStrutHeight: true, height: 2.3),
      text: TextSpan(
        children: [
          TextSpan(text: 'Where', style: context.titleLarge),
          TextSpan(
            text: ' love',
            style: context.titleLarge?.copyWith(
              color: context.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' goes into cooking and desire comes to the table.',
            style: context.titleLarge,
          ),
        ],
      ),
    );
  }
}
