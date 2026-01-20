import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/search/data/data_sources/data_source_repo.dart';
import 'package:recipe/feature/search/data/data_sources/local_data_source/local_data_source_repo.dart';

class SearchDataSourceRepoImpl extends SearchDataSourceRepo {
  final LocalSearchDataSourceRepo localData;
  SearchDataSourceRepoImpl({required this.localData});
  @override
  SearchResultData searchRecipe(String recipe) async {
    final localDBResult = await localData.localSearchRecipe(recipe);
    return localDBResult.fold((failer) {
      /**
     * for now i just pasing the value as failer
     */
      return Left(CacheFailure('fialed'));
    }, (sucess) => Right(SuccessHandlerImpl(sucess.data)));
  }
}
