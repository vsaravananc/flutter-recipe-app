import 'package:go_router/go_router.dart';
import 'package:recipe/core/extensions/color_extension.dart';
import 'package:recipe/core/extensions/textstyle_extension.dart';
import 'package:recipe/core/services/beral_container.dart';

class SliverAppBarWidget extends SliverPersistentHeaderDelegate {
  InputBorder _inputBorder(BuildContext context) => OutlineInputBorder(
    borderSide: BorderSide(color: context.primary, width: 0.8),
    borderRadius: .circular(12),
  );
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 200,
      width: .infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.shadowColor.withValues(alpha: 0.2),
            offset: const Offset(0, 5),
            blurRadius: 4,
            spreadRadius: 4,
          ),
        ],
        color: Theme.of(context).cardColor,
        borderRadius: const .vertical(bottom: Radius.circular(30)),
      ),

      child: Column(
        spacing: 5,
        crossAxisAlignment: .start,
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text("Search Recipe", style: context.titleLarge),
            centerTitle: true,
          ),

          Padding(
            padding: const .symmetric(horizontal: 12),
            child: TextFormField(
              autofocus: true,
              keyboardType: .text,
              onChanged: (search) async {
                await Future.delayed(const Duration(milliseconds: 800));
                if (context.mounted) {
                  context.read<SearchBloc>().add(
                    TriggerSearchEvent(search: search),
                  );
                }
              },
              decoration: InputDecoration(
                hintText: "Briyani Recipe",
                border: _inputBorder(context),
                enabledBorder: _inputBorder(context),
                disabledBorder: _inputBorder(context),
                errorBorder: _inputBorder(context),
                focusedBorder: _inputBorder(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 200;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
