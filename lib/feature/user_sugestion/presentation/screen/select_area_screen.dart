import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/feature/user_sugestion/presentation/bloc/userprefrences_bloc.dart';
import 'package:recipe/feature/user_sugestion/presentation/selectedarea/selectedarea_cubit.dart';
import 'package:recipe/feature/user_sugestion/presentation/widgets/app_bar_widget.dart';

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
      appBar: const AppBarWidget(title: "Select your preferred Country"),
      body: BlocBuilder<UserprefrencesBloc, UserprefrencesState>(
        builder: (context, state) {
          if (state is UserprefrencesLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.only(bottom: 30),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
                childAspectRatio: 4,
              ),
              itemCount: state.areas.length,
              itemBuilder: (con, index) {
                bool isSelected =
                    (con.watch<SelectedareaCubit>().state.areaEntities?.area ?? "") ==
                    state.areas[index].area;
                return Material(
                  color: isSelected
                      ? context.primary
                      : context.tertiaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    splashColor: context.secondary,
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      context.read<SelectedareaCubit>().selectArea(
                        state.areas[index],
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.transprent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          state.areas[index].area,
                          style: context.bodyLarge?.copyWith(
                            color: isSelected
                                ? context.onPrimary
                                : context.onTertiaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
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
