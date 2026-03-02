import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/feature/profile/presentation/bloc/profile_bloc.dart';

List<String> avata = [
  AppImages.avatar,
  AppImages.avatar1,
  AppImages.avatar2,
  AppImages.avatar3,
  AppImages.avatar4,
  AppImages.avatar5,
];

class ProfileImagePickerWidget extends StatefulWidget {
  const ProfileImagePickerWidget({super.key});

  @override
  State<ProfileImagePickerWidget> createState() =>
      _ProfileImagePickerWidgetState();
}

class _ProfileImagePickerWidgetState extends State<ProfileImagePickerWidget> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.53);
    final current = context.read<ProfileBloc>().state.profileEntitie.image;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.animateToPage(
        avata.indexOf(current),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile_avatar',
      child: SizedBox(
        height: 220,
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return PageView.builder(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              scrollDirection: .horizontal,
              allowImplicitScrolling: true,
              onPageChanged: (i) {
                context.read<ProfileBloc>().add(ProfileImageChanged(avata[i]));
              },
              itemBuilder: (c, i) {
                bool isSelected = state.profileEntitie.image == avata[i];
                return AnimatedContainer(
                  padding: .symmetric(vertical: isSelected ? 0 : 20),
                  duration: const Duration(milliseconds: 200),
                  child: ImageFiltered(
                    imageFilter: isSelected
                        ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                        : ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Image.asset(avata[i]),
                  ),
                );
              },
              itemCount: avata.length,
            );
          },
        ),
      ),
    );
  }
}
