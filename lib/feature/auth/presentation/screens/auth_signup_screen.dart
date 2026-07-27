import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/core/extensions/padding_extension.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/validator/validation.dart';
import 'package:recipe/core/extensions/localization_extension.dart';
import 'package:recipe/feature/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe/feature/auth/presentation/bloc/auth_ui_bloc/auth_ui_bloc.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_button_widget.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_divider_holder_widget.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_icon_button_widget.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_textformfield_widget.dart';

class AuthSignUpScreen extends StatefulWidget {
  const AuthSignUpScreen({super.key});

  @override
  State<AuthSignUpScreen> createState() => _AuthSignUpScreenState();
}

class _AuthSignUpScreenState extends State<AuthSignUpScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearText() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(60)),
      ),
      elevation: 4,
      child: BlocConsumer<AuthBloc, AuthState>(
        builder: (c, state) => Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Text(
                  context.l10n.auth_sign_up,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: context.l10n.auth_already_have_account,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: context.l10n.auth_login_link,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _clearText();
                            context.read<AuthUIBloc>().add(AuthChangeLogIn());
                          },
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                AnimatedBuilder(
                  animation: Listenable.merge([
                    _nameFocusNode,
                    _emailFocusNode,
                    _passwordFocusNode,
                  ]),
                  builder: (context, _) {
                    bool isFocused =
                        (_nameFocusNode.hasFocus ||
                        _emailFocusNode.hasFocus ||
                        _passwordFocusNode.hasFocus);
                    return AnimatedSwitcher(
                      duration: 100.ms,
                      reverseDuration: 200.ms,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween(
                              begin: .95,
                              end: 1.0,
                            ).animate(animation),
                            child: SlideTransition(
                              position: Tween(
                                begin: const Offset(0, -0.08),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          ),
                        );
                      },
                      child: isFocused
                          ? const SizedBox()
                          : Column(
                              children: [
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
                                  child: AuthDividerHolderWidget(
                                    text: context.l10n.login,
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                ),

              

                AuthTextFormFieldWidget(
                  iconData: HugeIcons.strokeRoundedUser,
                  validator: (val) => Validation.name(context, val),
                  label: context.l10n.auth_fullname,
                  hint: context.l10n.auth_hint_fullname,
                  isObscure: false,
                  focusNode: _nameFocusNode,
                  textCapitalization: .words,
                  suffixWidgetIcon: HugeIcons.strokeRoundedUser,
                  autofillHints: [
                    AutofillHints.name
                  ],
                  textInputAction: .next,
                  formates: [],
                  inputType: TextInputType.text,
                  controller: _nameController,
                ).paddingOnlyTop(top: 5),
                const SizedBox(height: 15),

                AuthTextFormFieldWidget(
                  iconData: HugeIcons.strokeRoundedMail02,
                  label: context.l10n.auth_email,
                  hint: context.l10n.auth_hint_email,
                  isObscure: false,
                  suffixWidgetIcon: HugeIcons.strokeRoundedMail02,
                  focusNode: _emailFocusNode,
                  textInputAction: .next,
                  autofillHints: [
                    AutofillHints.email
                  ],
                  formates: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9@._-]'),
                    ),
                  ],
                  validator: (val) => Validation.email(context, val),
                  inputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                const SizedBox(height: 15),

                AuthTextFormFieldWidget(
                  iconData: HugeIcons.strokeRoundedKey01,
                  suffixWidgetIcon: HugeIcons.strokeRoundedKey01,
                  validator: (val) => Validation.password(context, val),
                  label: context.l10n.auth_password,
                  hint: context.l10n.auth_hint_password,
                  isObscure: true,
                  focusNode: _passwordFocusNode,
                  formates: [],
                  inputType: TextInputType.text,
                  controller: _passwordController,
                ).paddingOnlyBottom(bottom: 5),
                const SizedBox(height: 15),

                AuthButtonWidget(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          if (_form.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthSignUpEvent(
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                  text: context.l10n.auth_register,
                ),
             

                const Spacer(flex: 4),
             
              ],
            ),
          ),
        ),
        listener: (c, s) {
          if (s is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.auth_signup_success_msg)),
            );
          }
          if (s is AuthSuccess) {
            _clearText();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(s.user.uid)));
            context.read<AuthUIBloc>().add(AuthChangeLogIn());
          }
        },
      ),
    );
  }
}
