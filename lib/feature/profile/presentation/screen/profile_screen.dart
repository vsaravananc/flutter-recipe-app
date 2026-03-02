import 'package:flutter/material.dart';
import 'package:recipe/feature/profile/presentation/widget/profile_image_picker_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int pointer = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Column(
        crossAxisAlignment: .center,
        children: [
          ProfileImagePickerWidget(
            key: Key('profile_image_picker'),
          ),
        ],
      ),
    );
  }
}
