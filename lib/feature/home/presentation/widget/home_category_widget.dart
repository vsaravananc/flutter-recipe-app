import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/feature/home/presentation/bloc/home_category_bloc/homecategory_bloc.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomecategoryBloc, HomecategoryState>(
      builder: (context, state) {
        if (state is HomecategoryInitial) {
          return const SizedBox.shrink();
        } else if (state is HomecategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomecategoryError) {
          return const Center(child: Text("Something went wrong"));
        } else {
          final result = state as HomecategoryLoaded;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: result.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = result.categories[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: context.secondary,
                          borderRadius: BorderRadiusGeometry.circular(30),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      imageUrl: category.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 5),
                    Text(category.name),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
