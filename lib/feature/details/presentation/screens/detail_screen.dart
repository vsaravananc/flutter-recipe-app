import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
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
        child: Column(
          crossAxisAlignment: .start,
          spacing: 5,
          children: [
            Hero(
              tag: widget.foodDetail.imageTag,
              child: DetailFoodImage(
                imageUrl: widget.foodDetail.image,
                key: ValueKey('detail_${widget.foodDetail.imageTag}'),
              ),
            ),
            Padding(
              padding: const .symmetric(horizontal: 12),
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

            DetailFoodDetail(
              foodName: widget.foodDetail.title,
              key: ValueKey('detail_food_${widget.foodDetail.titleTag}'),
            ),
            const Text(
              "step 1\r\nPeel and devein most of the prawns (a fishmonger should be able to do this for you), keeping a few whole for decoration, if you like. Heat the olive oil in a large frying pan or shallow flameproof casserole over a medium-low heat and fry the onion for 5 mins until softened. Add the bay leaf, saffron, rice and tomato purée, and cook for 1-2 mins more, stirring.\r\n\r\nstep 2\r\nPour in the wine and bubble for 1-2 mins, then pour in the seafood stock and 150ml water. Cook for 5 mins, then add the squid, season well and stir to combine. Bring to the boil, then cover and reduce the heat to a gentle simmer. Cook for 12 mins more, adding a little more water if the mixture starts to look dry.\r\n\r\nstep 3\r\nUncover the pan and stir through the peeled prawns, then arrange any whole prawns on top of the rice mixture. Cover again and simmer for a further 5-6 mins until the prawns are pink and cooked through. Leave to stand for a couple of minutes before serving from the pan.",
            ),
          ],
        ),
      ),
    );
  }
}
