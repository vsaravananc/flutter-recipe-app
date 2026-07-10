import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/core/services/beral_container.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/core/util/app_color.dart';
import 'package:recipe/core/util/app_fonts.dart';
import 'package:recipe/core/widgets/custom_button_widget.dart';

class WelcomeGreetingAnimationWidget extends StatelessWidget {
  const WelcomeGreetingAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppColor.scaffoldBackground.withValues(alpha: 0.1),
                AppColor.scaffoldBackground.withValues(alpha: 0.4),
                AppColor.scaffoldBackground.withValues(alpha: 0.8),
                AppColor.scaffoldBackground,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const Spacer(flex: 3),
                  RichText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    text: const TextSpan(
                      text: "You'r ",
                      style: TextStyle(
                        fontFamily: AppFonts.inter,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Recipe Heaven",
                          style: TextStyle(
                            fontFamily: AppFonts.inter,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColor.primary,
                          ),
                        ),
                        TextSpan(text: "\nAwaits Exploration!"),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.p12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Discover delicious recipes and cooking tips from around the world.",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppFonts.inter,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textDisable,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.p16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.p16,
                    ),
                    child: CustomButtonWidget(
                      widget: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 4,
                        children: [
                          Text(
                            "Get Started",
                            style: TextStyle(
                              color: AppColor.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedArrowRight02,
                            color: AppColor.onPrimary,
                          ),
                        ],
                      ),
                      onPressed: () {
                        context.go(AppRouterConfig.welcomeRoute);
                      },
                    ),
                  ),
                  const Spacer(),
            ],
          ),
)
        .animate(delay: 200.ms)
        .fadeIn(duration: 300.ms, curve: Curves.easeOut)
        .moveY(begin: 30, end: 0, duration: 450.ms, curve: Curves.easeOutCubic)
        .scale(
          begin: const Offset(0.98, 0.98),
          end: const Offset(1, 1),
          duration: 450.ms,
          curve: Curves.easeOutQuart,
    );
  }
}
