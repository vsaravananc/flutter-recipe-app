import 'package:flutter/material.dart';

class DetailFoodShimmer extends StatelessWidget {
  const DetailFoodShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 10,
      children: [
        Container(
          height: 13,
          width: 80,
          margin: const .only(top: 5),
          decoration: BoxDecoration(
            borderRadius: .circular(8),
            gradient: LinearGradient(
              colors: [Colors.grey.shade100, Colors.grey.shade200],
            ),
          ),
        ),

        Container(
          height: 18,
          width: 90,
          margin: const .only(top: 8),
          decoration: BoxDecoration(
            borderRadius: .circular(8),
            gradient: LinearGradient(
              colors: [Colors.grey.shade100, Colors.grey.shade200],
            ),
          ),
        ),

         Container(
          height: 18,
          width: 120,
          margin: const .only(top: 8),
          decoration: BoxDecoration(
            borderRadius: .circular(8),
            gradient: LinearGradient(
              colors: [Colors.grey.shade100, Colors.grey.shade200],
            ),
          ),
        ),

        ListView.separated(
          padding: const .all(0),
          itemBuilder: (c, i) => const SizedBox(height: 5),
          separatorBuilder: (c, i) => Row(
            crossAxisAlignment: .end,
            spacing: 8,
            children: [
              const CircleAvatar(radius: 5,backgroundColor: Color(0xFFEAE6E6),),
              Container(
                height: 12,
                width: 120,
                margin: const .only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: .circular(8),
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade100, Colors.grey.shade200],
                  ),
                ),
              ),
            ],
          ),
          itemCount: 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: .vertical,
        ),
      ],
    );
  }
}
