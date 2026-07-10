import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';

class WelcomeMobileHolderWidget extends StatelessWidget {
  final int count;
  final PageController pageController;
  final Function(int) onChange;
  const WelcomeMobileHolderWidget({
    super.key,
    required this.count,
    required this.pageController,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.topCenter,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Image.asset(AppImages.mock),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 286,maxHeight: 640),
          child: Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: ClipRRect(
              borderRadius: const BorderRadiusGeometry.vertical(
                top: Radius.elliptical(46, 38),
              ),
              child: PageView.builder(
                controller: pageController,
                itemCount: count,
                pageSnapping: true,
                onPageChanged: onChange,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.orange[(index + 1) * 100],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 17,
          child: Container(
            width: 74,
            height: 23,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(70),
            ),
          ),
        ),
      ],
    );
  }
}
