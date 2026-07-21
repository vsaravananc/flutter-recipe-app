import 'package:flutter/material.dart';
import 'package:recipe/feature/profile/presentation/widget/profile_image_picker_widget.dart';
import 'package:recipe/core/extensions/localization_extension.dart';

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
        title: Text(context.l10n.profile_title),
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
