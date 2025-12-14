import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';
import 'package:recipe/feature/user_sugestion/presentation/bloc/userprefrences_bloc.dart';
import 'package:recipe/feature/user_sugestion/presentation/selected_user_suggestion/area/selectedarea_cubit.dart';
import 'package:recipe/feature/user_sugestion/presentation/selected_user_suggestion/category/selectedcategory_cubit.dart';
import 'package:recipe/feature/user_sugestion/presentation/widgets/user_sugestion_app_bar_widget.dart';
import 'package:recipe/feature/user_sugestion/presentation/widgets/user_sugestion_bottom_info_widget.dart';
import 'package:recipe/feature/user_sugestion/presentation/widgets/user_sugestion_select_button_widget.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Select a Category for Recipes",
        leadingIcon: true,
      ),
      bottomNavigationBar: const UserSugestionBottomInfoWidget(
        title: "category",
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
              itemCount: state.categories.length,
              itemBuilder: (con, index) {
                CategoryEntities areaEntities = state.categories[index];
                bool isSelected =
                    (con
                            .watch<SelectedcategoryCubit>()
                            .state
                            .categoryEntities
                            ?.category ??
                        "") ==
                    areaEntities.category;
                return UserSugestionSelectButtonWidget(
                  isSelected: isSelected,
                  title: areaEntities.category,
                  onTap: () {},
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
