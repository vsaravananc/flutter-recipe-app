import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:recipe/feature/details/data/data_source/detail_datasource_repo.dart';
import 'package:recipe/feature/details/data/data_source/local_data_source/local_data_source_repo.dart';
import 'package:recipe/feature/details/data/data_source/reomte_data_source/remote_data_source_repo.dart';

class DetailDatasourceRepoImpl implements DetailDatasourceRepo {
  final LocalDataSourceRepo localDataSourceRepo;
  final RemoteDataSourceRepo remoteDataSourceRepo;
  DetailDatasourceRepoImpl({
    required this.localDataSourceRepo,
    required this.remoteDataSourceRepo,
  });
  @override
  Future<GetFoodDetail> getFoodDetail({required String id}) async {
    final localResult = await localDataSourceRepo.getFoodDetail(id: id);
    return localResult.fold(
      (fialer) async {
        final remoteResult = await remoteDataSourceRepo.getFoodDetail(id: id);
        return remoteResult.fold((failer) => Left(failer), (succes) async {
          debugPrint("sucess : ${succes.data}");
          await localDataSourceRepo.addFoodDetail(foodModel: succes.data);
          return Right(succes);
        });
      },
      (success) {
        return Right(success);
      },
    );
  }
}
