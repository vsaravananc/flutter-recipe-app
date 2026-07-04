import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/services/beral_container.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/core/util/app_color.dart';
import 'package:recipe/core/util/app_fonts.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: SafeArea(
        top: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const SizedBox(height: double.infinity, width: double.infinity),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.75,
              child: Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.scaffoldBackground.withValues(alpha: 0.4),
                      Colors.transparent,
                      AppColor.scaffoldBackground,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Image.asset(
                  AppImages.welcome,
                  fit: BoxFit.cover,
                  height: MediaQuery.sizeOf(context).height * 0.75,
                  cacheWidth: MediaQuery.sizeOf(context).width.toInt(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: DraggableScrollableSheet(
                initialChildSize: 0.45,
                minChildSize: 0.45,
                maxChildSize: 0.45,
                expand: false,
                builder: (context, _) {
                  return const WelcomeGreetingAnimationWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeGreetingAnimationWidget extends StatefulWidget {
  const WelcomeGreetingAnimationWidget({super.key});

  @override
  State<WelcomeGreetingAnimationWidget> createState() =>
      _WelcomeGreetingAnimationWidgetState();
}

class _WelcomeGreetingAnimationWidgetState
    extends State<WelcomeGreetingAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return FadeTransition(
          opacity: _animationController,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(_animationController),
            child: Container(
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
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width > 360
                            ? 360
                            : double.infinity,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 0),
                          backgroundColor: AppColor.primary.withValues(
                            alpha: 0.3,
                          ),
                          surfaceTintColor: AppColor.primary,
                          elevation: 0,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimensions.p8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.p32,
                            vertical: Dimensions.p12,
                          ),
                          foregroundColor: AppColor.primary,
                        ),
                        onPressed: () {},
                        child: const Text("Get Started"),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
