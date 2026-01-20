import 'package:recipe/feature/search/data/data_sources/data_source_repo.dart';
import 'package:recipe/feature/search/domain/repo/search_domain_repo.dart';

class SearchDataRepoImpl extends SearchDomainRepo {
  final SearchDataSourceRepo dataSourceRepo;
  SearchDataRepoImpl({required this.dataSourceRepo});
  @override
  SearchRecipeResult searchRecipe(String recipe) async{
    return await dataSourceRepo.searchRecipe(recipe);
  }
}
