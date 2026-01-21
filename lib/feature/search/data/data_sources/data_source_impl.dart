import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/search/data/data_sources/data_source_repo.dart';
import 'package:recipe/feature/search/data/data_sources/local_data_source/local_data_source_repo.dart';
import 'package:recipe/feature/search/data/data_sources/remote_data_source/remote_data_source_repo.dart';

class SearchDataSourceRepoImpl extends SearchDataSourceRepo {
  final LocalSearchDataSourceRepo localData;
  final RemoteSearchDataSourceRepo remoteData;
  SearchDataSourceRepoImpl({required this.localData, required this.remoteData});
  @override
  SearchResultData searchRecipe(String recipe) async {
    final localDBResult = await localData.localSearchRecipe(recipe);
    return localDBResult.fold((failer) async {
      final remoteResult = await remoteData.remoteSearchRecipe(recipe);
      return remoteResult.fold(
        (failer) => Left(failer),
        (sucess) => Right(SuccessHandlerImpl(sucess.data)),
      );
    }, (sucess) => Right(SuccessHandlerImpl(sucess.data)));
  }
}
