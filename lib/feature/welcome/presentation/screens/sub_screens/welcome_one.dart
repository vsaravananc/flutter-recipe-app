import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/util/app_color.dart';

class WelcomeOne extends StatelessWidget {
  const WelcomeOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.topCenter,
      clipBehavior: Clip.none,
      children: [
        const SizedBox(height: double.infinity, width: double.infinity),
        Stack(
          children: [
            Transform.scale(
              alignment: Alignment.topCenter,
              scale: 0.78,
              child: Image.asset(AppImages.mock, fit: BoxFit.cover),
            ),

            Transform.scale(
              alignment: Alignment.topCenter,
              scale: 0.71,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                height: 800,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: AlignmentGeometry.bottomCenter,
          child: ClipPath(
            clipper: InvertedTopClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColor.scaffoldBackground,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("dummy")],
              ),
            ),
          ),
        )
      ],
    );
  }
}


class InvertedTopClipper extends CustomClipper<Path> {
  final double depth;

  InvertedTopClipper({this.depth = 25});

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
  bool shouldReclip(covariant InvertedTopClipper oldClipper) {
    return false;
  }
}
