import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/core/extensions/padding_extension.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/core/validator/validation.dart';
import 'package:recipe/core/extensions/localization_extension.dart';
import 'package:recipe/core/messages/error_messages.dart';
import 'package:recipe/feature/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_button_widget.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_divider_holder_widget.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_icon_button_widget.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_textformfield_widget.dart';
import 'package:recipe/feature/home/presentation/bloc/home_category_bloc/homecategory_bloc.dart';

class AuthLoginInScreen extends StatefulWidget {
  const AuthLoginInScreen({super.key});

  @override
  State<AuthLoginInScreen> createState() => _AuthLoginInScreenState();
}

class _AuthLoginInScreenState extends State<AuthLoginInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearText() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (c, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              spacing: 10,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 230),
                    child: Column(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .start,
                      spacing: 4,
                      children: [
                        Text(
                          context.l10n.auth_login_title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          context.l10n.auth_login_subtitle,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(height: 1.3),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: AuthIconButtonWidget(
                          imagePath: AppImages.googleSvg,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthLoginWithGoogleEvent(),
                            );
                          },
                          text: context.l10n.auth_google,
                        ),
                      ),
                      Expanded(
                        child: AuthIconButtonWidget(
                          imagePath: AppImages.facebookSvg,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthLoginWithGoogleEvent(),
                            );
                          },
                          text: context.l10n.auth_facebook,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: AuthDividerHolderWidget(text: context.l10n.login),
                ),

                AuthTextFormFieldWidget(
                  iconData: HugeIcons.strokeRoundedMail02,
                  label: context.l10n.auth_email,
                  isObscure: false,
                  focusNode: FocusNode(),
                  textInputAction: TextInputAction.next,
                  formates: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9@._-]'),
                    ),
                  ],
                  validator: (val) => Validation.email(context, val),
                  inputType: TextInputType.emailAddress,
                  controller: _emailController,
                ).paddingOnlyTop(top: 5),
                AuthTextFormFieldWidget(
                  textInputAction: TextInputAction.done,
                  iconData: HugeIcons.strokeRoundedKey01,
                  validator: (val) => Validation.password(context, val),
                  label: context.l10n.auth_password,
                  hint: context.l10n.auth_hint_password,
                  isObscure: true,
                  focusNode: FocusNode(),
                  formates: [],
                  inputType: TextInputType.text,
                  controller: _passwordController,
                ).paddingOnlyBottom(bottom: 5),

                const SizedBox(height: 15),
               
                AuthButtonWidget(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthLoginEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                            //? remove the below code
                            context.pushReplacement(
                              AppRouterConfig.dashBoardRoute,
                            );
                          }
                        },
                  text: context.l10n.auth_sign_in,
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        );
      },
      listener: (_, s) {
        if (s is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(ErrorMessages.getLocalizedMessage(context, s.message))));
        }
        if (s is AuthSuccess) {
          context.read<HomecategoryBloc>().add(FetchHomeCategories());
          _clearText();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(s.user.uid)));
          Future.delayed(const Duration(milliseconds: 200));
          context.pushReplacement(AppRouterConfig.dashBoardRoute);
        }
      },
    );
  }
}
