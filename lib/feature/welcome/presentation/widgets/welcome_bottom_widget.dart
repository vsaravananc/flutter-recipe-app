import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recipe/core/util/app_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeBottomWidget extends StatelessWidget {
  final List<Widget> widgets;
  final Function(int index) onChange;
  final PageController pageController;
  const WelcomeBottomWidget({
    super.key,
    required this.widgets,
    required this.onChange,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _InvertedTopClipperPainter(),
      child: ClipPath(
        clipper: const _InvertedTopClipperPathe(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          decoration: const BoxDecoration(color: AppColor.scaffoldBackground),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: widgets.length,
                pageSnapping: true,
                onPageChanged: onChange,
                itemBuilder: (context, index) {
                  return widgets[index]
                      .animate()
                      .blur(
                        begin: const Offset(8, 8),
                        end: Offset.zero,
                        duration: 400.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeIn(duration: 350.ms)
                      .moveY(
                        begin: 25,
                        end: 0,
                        duration: 450.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                        duration: 450.ms,
                      );
                },
              ),
              Positioned(
                bottom: 30,
                child: SafeArea(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: widgets.length,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: AppColor.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InvertedTopClipperPainter extends CustomPainter {
  const _InvertedTopClipperPainter();

  final double depth = 25;
  
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.cubicTo(0, 0, size.width * 0.2, depth, size.width / 2, depth);
    path.cubicTo(size.width * 0.8, depth, size.width, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

   
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha:0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawPath(path.shift(const Offset(0, -2)), shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw false;
  }
}
class _InvertedTopClipperPathe extends CustomClipper<Path> {
  const _InvertedTopClipperPathe();

  final double depth = 25;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.cubicTo(
      size.width * 0,
      0,
      size.width * 0.2,
      depth,
      size.width / 2,
      depth,
    );

    path.cubicTo(size.width * 0.8, depth, size.width * 1, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _InvertedTopClipperPathe oldClipper) {
    return false;
  }
}
