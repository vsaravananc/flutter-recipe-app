import 'package:flutter/material.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/core/util/app_color.dart';

class CustomButtonWidget extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final Widget? widget;
  final bool? isLoading;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  const CustomButtonWidget({
    super.key,
    this.text,
    this.widget,
    this.textStyle,
    this.isLoading = false,
    this.onPressed,
    this.buttonColor = AppColor.primary,
  }) : assert(
         (text != null && widget == null) || (text == null && widget != null),
         'Either text or widget must be provided, but not both.',
       );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading! ? null : onPressed,
      child: Container(
        
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width > 360
              ? 360
              : double.infinity,
        ),
        height: 45,
        decoration: ShapeDecoration(
          color: isLoading! ? AppColor.disable : buttonColor,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(28),
          ),
        ),
        child: isLoading!
            ? const Padding(
                padding: EdgeInsets.all(Dimensions.p4),
                child: CircularProgressIndicator(color: AppColor.onPrimary),
              )
            : widget ??
                  Center(
                    child: Text(
                      text!,
                      style:
                          textStyle ??
                          const TextStyle(
                            color: AppColor.onPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
      ),
    );
  }
}
