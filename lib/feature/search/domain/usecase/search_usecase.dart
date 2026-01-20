

import 'package:recipe/feature/search/domain/repo/search_domain_repo.dart';

class SearchUsecase {
  final SearchDomainRepo searchDomainRepo;
  const SearchUsecase({required this.searchDomainRepo});

  SearchRecipeResult searchRecipe(String recipe)async{
    return await searchDomainRepo.searchRecipe(recipe);
  }
}