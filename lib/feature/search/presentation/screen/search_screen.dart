import 'package:flutter/material.dart';
import 'package:recipe/feature/search/presentation/widget/sliver_appbar_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [SliverPersistentHeader(delegate: SliverAppBarWidget())],
      ),
    );
  }
}
