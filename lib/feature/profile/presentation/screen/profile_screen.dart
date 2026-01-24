import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe/core/images/app_images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int pointer = 0;
  List<String> avata= [
    AppImages.avatar,
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: .center,
        children: [
          const SizedBox(height: 0, width: .infinity),
          Hero(
            tag: 'profile_avatar',
            child: SizedBox(
              height: 220,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.53),
                physics: const ClampingScrollPhysics(),
                scrollDirection: .horizontal,
                allowImplicitScrolling: true,
                onPageChanged: (i) {
                  setState(() {
                    pointer = i;
                  });
                },
                itemBuilder: (c, i) => AnimatedContainer(
                  padding: .symmetric(vertical: i == pointer ? 0 : 20),
                  duration: const Duration(milliseconds: 200),
                  child: ImageFiltered(
                    imageFilter: i == pointer
                        ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                        : ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Image.asset(avata[i]),
                  ),
                ),
                itemCount: avata.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
