import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/core/extensions/padding_extension.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/core/validator/validation.dart';
import 'package:recipe/feature/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe/feature/auth/presentation/bloc/auth_ui_bloc/auth_ui_bloc.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_button_widget.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_divider_holder_widget.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_icon_button_widget.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_textformfield_widget.dart';

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
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            spacing: 10,
            children: [
              Text("Login", style: Theme.of(context).textTheme.headlineMedium),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don’t have an account? ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: "Sign Up",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _clearText();
                          context.read<AuthUIBloc>().add(AuthChangeSignUP());
                        },
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              AuthTextFormFieldWidget(
                iconData: HugeIcons.strokeRoundedMail02,
                label: "Email",
                hint: "Enter your email",
                isObscure: false,
                focusNode: FocusNode(),
                formates: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
                ],
                validator: Validation.email,
                inputType: TextInputType.emailAddress,
                controller: _emailController,
              ).paddingOnlyTop(top: 5),
              AuthTextFormFieldWidget(
                iconData: HugeIcons.strokeRoundedKey01,
                validator: Validation.password,
                label: "Password",
                hint: "Enter your Password",
                isObscure: true,
                focusNode: FocusNode(),
                formates: [],
                inputType: TextInputType.text,
                controller: _passwordController,
              ).paddingOnlyBottom(bottom: 5),
              const AuthDividerHolderWidget(text: "login"),
              AuthIconButtonWidget(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLoginWithGoogleEvent());
                },
                text: "Continue",
              ).paddingVertical(vertical: 10),
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
                        }
                      },
                text: "Log In",
              ),
            ],
          ),
        );
      },
      listener: (_, s) {
        if (s is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(s.message)));
        }
        if (s is AuthSuccess) {
          _clearText();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(s.user.uid)));
          Future.delayed(const Duration(milliseconds: 200));
          context.pushReplacement(AppRouterConfig.areaRoute);
        }
      },
    );
  }
}
