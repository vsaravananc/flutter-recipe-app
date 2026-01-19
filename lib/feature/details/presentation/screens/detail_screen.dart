import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/services/dimensions.dart';
import 'package:recipe/feature/details/domain/entities/detail_screenl_entitie.dart';
import 'package:recipe/feature/details/presentation/bloc/detail_bloc.dart';
import 'package:recipe/feature/details/presentation/widgets/detail_food_detail.dart';
import 'package:recipe/feature/details/presentation/widgets/detail_food_image.dart';

class DetailScreen extends StatefulWidget {
  final DetailScreenlEntitie foodDetail;
  const DetailScreen({super.key, required this.foodDetail});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    context.read<DetailBloc>().add(
      GetDetailData(detailId: widget.foodDetail.id),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const .all(0),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            
            Hero(
              tag: widget.foodDetail.imageTag,
              child: DetailFoodImage(
                imageUrl: widget.foodDetail.image,
                key: ValueKey('detail_${widget.foodDetail.imageTag}'),
              ),
            ),
            Padding(
              padding: const .only(left: 12,top: 8),
              child: Hero(
                tag: widget.foodDetail.titleTag,
                child: Text(
                  widget.foodDetail.title,
                  maxLines: 1,
                  overflow: .clip,
                  style: context.titleLarge?.copyWith(fontWeight: .bold),
                ),
              ),
            ),
    
            Padding(
              padding:  .only(bottom: Platform.isAndroid ?  Dimensions.p10 :0),
              child: DetailFoodDetail(
                key: ValueKey('detail_food_${widget.foodDetail.titleTag}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
