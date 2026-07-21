import 'package:flutter/material.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/feature/scanner/presentation/widget/custom_bar_code.dart';
import 'package:recipe/core/extensions/localization_extension.dart';

class ScannerScreen extends StatefulWidget {
  final DraggableScrollableController controller;
  final ScrollController scrollController;
  const ScannerScreen({
    super.key,
    required this.controller,
    required this.scrollController,
  });

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.scaffoldBackgroundColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),

      child: ListView(
        controller: widget.scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          Center(
            child: GestureDetector(
              onTap: () {
                if (widget.controller.isAttached) {
                  widget.controller.animateTo(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } 
              },
              child: Text(context.l10n.scanner_home_title, style: context.headlineMedium),
            ),
          ),
          const SizedBox(height: 16),
          const CustomBarCode(),
        ],
      ),
    );
  }
}
