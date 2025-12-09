import 'package:flutter/material.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Category',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          'Select Category',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
