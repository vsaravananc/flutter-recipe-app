import 'package:recipe/core/services/beral_container.dart';
import 'package:recipe/feature/search/presentation/widget/search_result_widget.dart';
import 'package:recipe/feature/search/presentation/widget/sliver_appbar_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSearch = context.select<SearchBloc, bool>(
      (bloc) => bloc.state is SearchResult,
    );
    return Scaffold(
      backgroundColor: isSearch
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0x0C000000),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(delegate: SliverAppBarWidget(), pinned: true),
          const SearchResultWidget(),
        ],
      ),
    );
  }
}
