import 'package:flutter/material.dart';
import 'package:recipe/feature/search/presentation/widget/sliver_appbar_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0C000000),
      body: CustomScrollView(
        slivers: [SliverPersistentHeader(delegate: SliverAppBarWidget())],
      ),
    );
  }
}
