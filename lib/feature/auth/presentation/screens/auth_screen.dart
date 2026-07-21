import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/util/app_color.dart';
import 'package:recipe/core/extensions/localization_extension.dart';
import 'package:recipe/feature/auth/presentation/screens/auth_login_screen.dart';
import 'package:recipe/feature/auth/presentation/screens/auth_signup_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Align(
              alignment: const Alignment(0.0, -0.9),
              child:
                  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: ShapeDecoration(
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(28),
                              ),
                              image: const DecorationImage(
                                image: AssetImage(AppImages.logoLight),
                              ),
                            ),
                          ),
                          Text(
                            "Recipe book",
                            style: TextTheme.of(context).headlineSmall
                                ?.copyWith(
                                  color: AppColor.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      )
                      .animate(delay: 100.ms)
                      .fade()
                      .scale(
                        begin: const Offset(0.98, 0.98),
                        end: const Offset(1, 1),
                        duration: 450.ms,
                        curve: Curves.easeOutQuart,
                      ),
            ),
          ),
          DraggableScrollableSheet(
                maxChildSize: 0.82,
                initialChildSize: 0.82,
                minChildSize: 0.82,
                builder: ((context, scrollController) =>
                    // const AuthLoginInScreen(
                    //   key: ValueKey('auth_login_holder'),
                    // )),
                    const AuthSignUpScreen(
                      key: ValueKey('auth_signup_screen'),
                    )),
              )
              .animate(delay: 100.ms)
              .moveY(
                begin: 25,
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
        ],
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: context.l10n.auth_dont_have_account,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: context.l10n.auth_sign_up,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.primary,
                          decorationThickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
