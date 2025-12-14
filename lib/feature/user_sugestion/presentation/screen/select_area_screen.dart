import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/route/app_router_config.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';
import 'package:recipe/feature/user_sugestion/presentation/bloc/userprefrences_bloc.dart';
import 'package:recipe/feature/user_sugestion/presentation/selected_user_suggestion/area/selectedarea_cubit.dart';
import 'package:recipe/feature/user_sugestion/presentation/widgets/user_sugestion_app_bar_widget.dart';
import 'package:recipe/feature/user_sugestion/presentation/widgets/user_sugestion_bottom_info_widget.dart';
import 'package:recipe/feature/user_sugestion/presentation/widgets/user_sugestion_select_button_widget.dart';

class SelectAreaScreen extends StatefulWidget {
  const SelectAreaScreen({super.key});

  @override
  State<SelectAreaScreen> createState() => _SelectAreaScreenState();
}

class _SelectAreaScreenState extends State<SelectAreaScreen> {
  @override
  void initState() {
    super.initState();
    ensureArea();
  }

  Future<void> ensureArea() async {
    if (context.read<UserprefrencesBloc>().state is! UserprefrencesLoaded) {
      context.read<UserprefrencesBloc>().add(UserprefrencesGetData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Select a Country for Recipes"),
      bottomNavigationBar: const UserSugestionBottomInfoWidget(
        title: "country",
      ),
      floatingActionButton: BlocBuilder<SelectedareaCubit, SelectedareaState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: state.areaEntities != null
                ? FloatingActionButton(
                    key: const ValueKey('floating_button'),
                    shape: const CircleBorder(),
                    onPressed: () {
                      context.push(AppRouterConfig.categoryRoute);
                    },
                    child: const Icon(Icons.arrow_forward),
                  )
                : const SizedBox.shrink(key: ValueKey('empty_floating_button')),
          );
        },
      ),
      body: BlocBuilder<UserprefrencesBloc, UserprefrencesState>(
        builder: (context, state) {
          if (state is UserprefrencesLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.only(bottom: 30),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 8,
                childAspectRatio: 4,
              ),
              itemCount: state.areas.length,
              itemBuilder: (con, index) {
                AreaEntities areaEntities = state.areas[index];
                bool isSelected =
                    (con.watch<SelectedareaCubit>().state.areaEntities?.area ??
                        "") ==
                    areaEntities.area;
                return UserSugestionSelectButtonWidget(
                  isSelected: isSelected,
                  title: areaEntities.area,
                  onTap: () {
                    context.read<SelectedareaCubit>().selectArea(
                      state.areas[index],
                    );
                  },
                );
              },
            );
          } else if (state is UserprefrencesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Text("No areas found", style: context.bodyMedium),
            );
          }
        },
      ),
    );
  }
}
