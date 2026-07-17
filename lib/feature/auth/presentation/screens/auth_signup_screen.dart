import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/core/extensions/padding_extension.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/validator/validation.dart';
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
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (c, state) => Form(
        key: _form,
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          spacing: 10,
          children: [
            Text("Sign Up", style: Theme.of(context).textTheme.headlineMedium),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: "Log In",
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
            AuthTextFormFieldWidget(
              iconData: HugeIcons.strokeRoundedUser,
              validator: Validation.name,
              label: "Full Name",
              hint: "Enter your Full Name",
              isObscure: false,
              focusNode: FocusNode(),
              formates: [],
              inputType: TextInputType.text,
              controller: _nameController,
            ).paddingOnlyTop(top: 5),
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
            ),

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
            const AuthDividerHolderWidget(text: "sign up"),
            AuthIconButtonWidget(
              imagePath: AppImages.facebookSvg,
              onPressed: () {},
              text: "Google",
            ).paddingVertical(vertical: 10),
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
              text: "Register",
            ),
          ],
        ),
      ),
      listener: (c, s) {
        if (s is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Sucessfully registered as user.")),
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
    );
  }
}
