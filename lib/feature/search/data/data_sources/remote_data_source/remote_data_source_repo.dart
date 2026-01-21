import 'package:recipe/feature/search/data/data_sources/data_source_repo.dart';

abstract class RemoteSearchDataSourceRepo {
  SearchResultData remoteSearchRecipe(String recipe);
}