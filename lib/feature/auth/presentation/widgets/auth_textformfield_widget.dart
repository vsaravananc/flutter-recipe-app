import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:recipe/core/util/app_color.dart';

class AuthTextFormFieldWidget extends StatelessWidget {
  final List<List<dynamic>> iconData;
  final String label;
  final String? hint;
  final VoidCallback? onpressed;
  final bool isObscure;
  final FocusNode focusNode;
  final List<TextInputFormatter> formates;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final List<List<dynamic>>? suffixWidgetIcon;
  const AuthTextFormFieldWidget({
    super.key,
    required this.iconData,
    required this.label,
    this.hint,
    this.onpressed,
    required this.isObscure,
    required this.focusNode,
    required this.formates,
    required this.inputType,
    this.validator,
    required this.controller,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.suffixWidgetIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autofillHints,
      key: ValueKey(label),
      inputFormatters: formates,
      textCapitalization: textCapitalization,
      keyboardType: inputType,
      focusNode: focusNode,
      textInputAction: textInputAction,
      validator: validator,
      controller: controller,
      obscureText: isObscure,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      cursorHeight: 18,
      cursorWidth: 2.1,

      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        suffix: suffixWidgetIcon != null
            ? Transform.translate(
                offset: const Offset(0, 6.5),
                child: HugeIcon(icon: suffixWidgetIcon!),
              )
            : null,
        label: Text(label),
        hintText: hint,
        floatingLabelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColor.primary,
        ),
        labelStyle: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        isDense: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}


/**
 *  decoration: InputDecoration(
        label: Text(label),
        hintText: hint,
        suffixIcon: GestureDetector(
          onTap: onpressed,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: HugeIcon(icon: iconData),
          ),
        ),
      ),
 */