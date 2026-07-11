import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/core/util/app_color.dart';
import 'package:recipe/core/util/app_fonts.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_bottom_widget.dart';
import 'package:recipe/feature/welcome/presentation/widgets/welcome_mobile_holder_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController pageController = PageController(initialPage: 0);
  PageController pageController2 = PageController(initialPage: 0);
  ValueNotifier<bool> showNext = ValueNotifier(false);
  late Timer timer;

  final List<Widget> _widgets = [
    _WelcomeMessageWidget(
      widget: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 180),
        child: RichText(
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: const TextSpan(
            text: "Save and Organize ",
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: 'Your Best Recipes.',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    _WelcomeMessageWidget(
      widget: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 180),
        child: RichText(
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: const TextSpan(
            text: "Explore a ",
            style: TextStyle(
              color: AppColor.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: 'World of ',
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: 'Culinary ',
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: 'Delights',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    _WelcomeMessageWidget(
      widget: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 220),
        child: RichText(
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          text: const TextSpan(
            text: "Interactive Cooking : ",
            style: TextStyle(
              color: AppColor.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: 'Join the Chef in real time.',
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ];


  @override
  void initState() {
    super.initState();
    _scrollHint();
  }

  void _scrollHint() async {
    double handOffset = 20;
    await Future.delayed(800.ms);
    timer = Timer.periodic(1500.ms, (_) {
      if (pageController.offset < 100) {
        pageController2.animateTo(
          handOffset,
          duration: 600.ms,
          curve: Curves.fastEaseInToSlowEaseOut,
        );
        handOffset = (handOffset + 10).clamp(10, 90);
      } else {
        handOffset = 0;
      }
    });
  }
  
  @override
  void dispose() {
    pageController.dispose();
    pageController2.dispose();
    showNext.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          TextButton(
            style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            onPressed: () {},
            child: AnimatedBuilder(
              animation: showNext,
              builder: (context, _) {
                return AnimatedSwitcher(
                  duration: 250.ms,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    ).animate().moveY(
                      begin: 8,
                      end: 0,
                      duration: 250.ms,
                      curve: Curves.easeOutCubic,
                    );
                  },
                  child: Text(
                    showNext.value ? 'Next' : 'Skip',
                    key: ValueKey(showNext.value),
                    style: const TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                );
              },
            )
          ),
        ],
      ),
      body: Stack(
        alignment: AlignmentGeometry.topCenter,
        clipBehavior: Clip.none,
        children: [
          const SizedBox(height: double.infinity, width: double.infinity),
          Align(
            alignment: AlignmentGeometry.topCenter,
            child: WelcomeMobileHolderWidget(
              count: _widgets.length,
              pageController: pageController2,
              onChange: (index) {
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                    if (index == 2) {
                      showNext.value = true;
                    } else if (index < 2 && showNext.value) {
                      showNext.value = false;
                    }
              },
            ),
              )
              .animate(delay: 200.ms)
              .fadeIn(duration: 450.ms, curve: Curves.easeOut)
              .moveY(
                begin: 50,
                end: 0,
                duration: 450.ms,
                curve: Curves.easeOutQuart,
              )
              .scale(
                begin: const Offset(0.98, 0.98),
                end: const Offset(1, 1),
                duration: 450.ms,
                curve: Curves.easeOutQuart,
              ),
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: WelcomeBottomWidget(
              widgets: _widgets,
              onChange: (_) {},
              pageController: pageController,
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeMessageWidget extends StatelessWidget {
  final Widget widget;
  const _WelcomeMessageWidget({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          widget,
          const SizedBox(height: Dimensions.p20),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adip happy to see you but you\'r',
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppFonts.inter,
              fontSize: 14,
              color: AppColor.secondaryTextColor,
              height: 1.3,
            ),
          ),
          const Spacer(flex: 2,),
        ],
      ),
    );
  }
}
