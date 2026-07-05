import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/core/util/app_color.dart';
import 'package:recipe/core/util/app_fonts.dart';
import 'package:recipe/feature/welcome/presentation/screens/sub_screens/welcome_one.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController pageController = PageController(initialPage: 0);
  PageController pageController2 = PageController(initialPage: 0);

  final List<Widget> _widgets = [
    WelcomeMessageWidget(
      widget: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 180),
        child: RichText(
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: const TextSpan(
            text: "Save and Organize ",
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: 'Your Best Recipes.',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    WelcomeMessageWidget(
      widget: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 180),
        child: RichText(
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: const TextSpan(
            text: "Explore a ",
            style: TextStyle(
              color: AppColor.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: 'World of ',
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: 'Culinary ',
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: 'Delights',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    WelcomeMessageWidget(
      widget: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 220),
        child: RichText(
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          text: const TextSpan(
            text: "Interactive Cooking : ",
            style: TextStyle(
              color: AppColor.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: 'Join the Chef in real time.',
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  
  @override
  void dispose() {
    pageController.dispose();
    pageController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          TextButton(
            style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(
                color: AppColor.primary,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: AlignmentGeometry.topCenter,
        clipBehavior: Clip.none,
        children: [
          const SizedBox(height: double.infinity, width: double.infinity),
          Align(
            alignment: AlignmentGeometry.topCenter,
            child: Stack(
              alignment: AlignmentGeometry.topCenter,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: Image.asset(AppImages.mock),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 286),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadiusGeometry.vertical(
                        top: Radius.elliptical(46, 38),
                      ),
                      child: PageView.builder(
                        controller: pageController2,
                        itemCount: 3,
                        pageSnapping: true,
                        onPageChanged: (index) {
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
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
            ),
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
                child: Stack(
                  alignment: AlignmentGeometry.bottomCenter,
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: _widgets.length,
                      pageSnapping: true,
                      onPageChanged: (index) {
                        pageController2.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      },
                      itemBuilder: (context, index) {
                        return _widgets[index];
                      },
                    ),
                    const Positioned(
                      bottom: 30,
                      child: SafeArea(child: Text("dots")),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeMessageWidget extends StatelessWidget {
  final Widget widget;
  const WelcomeMessageWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.p20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          widget,
          const SizedBox(height: Dimensions.p20),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adip happy to see you but you\'r',
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppFonts.inter,
              fontSize: 14,
              color: AppColor.secondaryTextColor,
              height: 1.2,
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
