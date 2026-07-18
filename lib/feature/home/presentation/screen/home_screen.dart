import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/extensions/localization_extension.dart';
import 'package:recipe/feature/home/domain/entities/home_category_entities.dart';
import 'package:recipe/feature/home/presentation/bloc/home_backtotop_cubit/bactotop_cubit.dart';
import 'package:recipe/feature/home/presentation/bloc/home_category_bloc/homecategory_bloc.dart';
import 'package:recipe/feature/home/presentation/bloc/home_recipe_bloc/recipe_bloc.dart';
import 'package:recipe/feature/home/presentation/widget/home_category_widget.dart';
import 'package:recipe/feature/home/presentation/widget/home_header_widget.dart';
import 'package:recipe/feature/home/presentation/widget/home_recipe_widget.dart';
import 'package:recipe/feature/home/presentation/widget/home_search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_listenScrollController);
    _initFirstCall();
  }

  void _initFirstCall() {
    if (context.read<HomecategoryBloc>().state is HomecategoryLoaded) {
      final HomeCategoryEntities categoryEntities =
          (context.read<HomecategoryBloc>().state as HomecategoryLoaded)
              .selectedCategories;
      context.read<HomeRecipeBloc>().add(
        GetRecipeEvent(categoryName: categoryEntities.name),
      );
    }
  }

  void _listenScrollController() {
    if (scrollController.position.pixels > 600) {
      context.read<BactotopCubit>().show();
    } else {
      context.read<BactotopCubit>().hide();
    }
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            const HomeHeaderWidget(key: ValueKey("home_header_widget")),
            HomeSearchWidget(
              key: const ValueKey("home_search_widget"),
              scrollController: scrollController,
            ),
            const HomeCategoryWidget(key: ValueKey("home_category_widget")),
            const HomeRecipeWidget(key: ValueKey("home_recipe_widget")),
          ],
        ),
      ),
      floatingActionButtonLocation: .centerDocked,
      floatingActionButton: BlocBuilder<BactotopCubit, BactotopState>(
        builder: (_, state) {
          debugPrint("BACK TO TOP : ${(state is BactotopShow)}");
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            reverseDuration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) {
              Animation<Offset> position = Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation);
              Animation<double> scale = Tween<double>(
                begin: .9,
                end: 1,
              ).animate(animation);
              return ScaleTransition(
                scale: scale,
                child: SlideTransition(position: position, child: child),
              );
            },
            child: (state is BactotopShow)
                ? GestureDetector(
                    onTap: () => scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    child: Container(
                      height: 50,
                      margin: const .only(bottom: 20),
                      padding: const .symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: .circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      key: const ValueKey("show_button"),
                      child: Row(
                        mainAxisSize: .min,
                        spacing: 8,
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 19,
                          ),
                          Text(
                            context.l10n.home_back_to_top,
                            style: context.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: .w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey("hide_button")),
          );
        },
      ),
    );
  }
}
