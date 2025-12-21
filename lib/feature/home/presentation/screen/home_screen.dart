import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/feature/home/presentation/bloc/home_category_bloc/homecategory_bloc.dart';
import 'package:recipe/feature/home/presentation/widget/home_category_widget.dart';
import 'package:recipe/feature/home/presentation/widget/home_header_widget.dart';
import 'package:recipe/feature/home/presentation/widget/home_search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    if (mounted) {
      context.read<HomecategoryBloc>().add(FetchHomeCategories());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const HomeHeaderWidget(),
            HomeSearchWidget(),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: HomeCategoryWidget(
                  key:  ValueKey("home_category_widget"),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(title: Text('Item #$index')),
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
