import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/home/data/data_source/data_source_repo.dart';
import 'package:recipe/feature/home/data/data_source/local_data_source/local_data_source_repo.dart';
import 'package:recipe/feature/home/data/data_source/remote_data_source/remote_data_source_repo.dart';
import 'package:recipe/feature/home/data/model/home_category_model.dart';

class DataSourceHomeRepoImpl implements DataSourceRepo {
  final LocalDataSourceHomeRepo localDataRepo;
  final RemoteDataSourceHomeRepo remoteDataRepo;

  DataSourceHomeRepoImpl({
    required this.localDataRepo,
    required this.remoteDataRepo,
  });
  @override
  Future<Either<FailerHandler, SuccessHandler<List<HomeCategoryModel>>>>
  fetchCategoryData() async {
    final localDataResult = await localDataRepo.fetchCategoryData();
    return localDataResult.fold((failer) async {
      debugPrint("Fetching from remote ${failer.message}");
      final remoteDataResult = await remoteDataRepo.fetchCategoryData();
      return remoteDataResult.fold((failer) => Left(failer), (success) async {
        await localDataRepo.addCategoryData(success.data);
        return Right(success);
      });
    }, (success) => Right(success));
  }
}
