import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/feature/auth/presentation/widgets/auth_textformfield_widget.dart';

class AuthLoginInScreen extends StatelessWidget {
  const AuthLoginInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
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
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            AuthTextFormFieldWidget(
              iconData: HugeIcons.strokeRoundedMail02,
              label: "Email",
              hint: "Enter your email",
              isObscure: false,
              focusNode: FocusNode(),
              formates: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) return "Enter email";
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return "Invalid email";
                }
                return null;
              },
              inputType: TextInputType.emailAddress,
              controller: TextEditingController(),
            ),
            AuthTextFormFieldWidget(
              iconData: HugeIcons.strokeRoundedKey01,
              label: "Password",
              hint: "Enter your Password",
              isObscure: true,
              focusNode: FocusNode(),
              formates: [],
              inputType: TextInputType.text,
              controller: TextEditingController(),
            ),
          ],
        ),
      ),
    );
  }
}
