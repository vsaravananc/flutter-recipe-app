import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/data_sources_repo.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/local_data_source/local_data_repo_user_sugestion.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/remote_data_source/remote_data_repo_user_sugestion.dart';
import 'package:recipe/feature/user_sugestion/data/model/area_model.dart';
import 'package:recipe/feature/user_sugestion/data/model/category_model.dart';

class DataSourcesRepoImpl implements DataSourcesRepo {
  final LocalDataRepoUserSugestion localData;
  final RemoteDataRepoUserSugestion remoteData;

  DataSourcesRepoImpl({required this.localData, required this.remoteData});
  @override
  Future<Either<FailerHandler, SuccessHandler<List<AreaModel>>>>
  getListOfArea() async {
    final fromLocal = await localData.getListOfArea();
    return fromLocal.fold((_) async {
      final fromRemote = await remoteData.getListOfArea();

      return await fromRemote.fold((failer) => Left(failer), (success) async {
        await localData.insertListOfArea(success.data);
        return Right(success);
      });
    }, (sucess) => Right(sucess));
  }

  @override
  Future<Either<FailerHandler, SuccessHandler<List<CategoryModel>>>>
  getListOfCategory() async {
    final fromLocal = await localData.getListOfCategory();
    return fromLocal.fold((_) async {
      final fromRemote = await remoteData.getListOfCategory();

      return await fromRemote.fold((failer) => Left(failer), (success) async {
        await localData.insertListOfCategory(success.data);
        return Right(success);
      });
    }, (sucess) => Right(sucess));
  }

  @override
  SelectedArea selectedArea(AreaModel category) async {
    final String uuid = await localData.selectedArea(category);
    await remoteData.selectedArea(category, uuid);
  }

  @override
  SelectedCategory selectedCategory(CategoryModel category) async {
    final String uuid = await localData.selectedCategory(category);
    await remoteData.selectedCategory(category, uuid);
  }
}
