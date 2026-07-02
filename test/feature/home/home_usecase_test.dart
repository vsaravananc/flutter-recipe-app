import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe/core/api/endpoints/api_endpoints.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/home/data/data_source/local_data_source/local_data_source_repo_impl.dart';
import 'package:recipe/feature/home/data/data_source/remote_data_source/remote_data_source_repo_impl.dart';
import 'package:recipe/feature/home/domain/repo/home_repo.dart';
import 'package:recipe/feature/home/domain/use_cases/home_category.dart';
import 'package:sqflite/sqflite.dart';

class MockHomeRepo extends Mock implements HomeRepo {}

/* DATABSE MOCK */
class MockDatabase extends Mock implements Database {}

/* DIO API MOCK */
class MockDio extends Mock implements Dio {}

void main() {
  test(
    'Give a LocalDataSourceHomeRepoImpl , when fetchCateoryData called then return then it should return a empty list of home categories Model',
    () async {
      final Database db = MockDatabase();
      final LocalDataSourceHomeRepoImpl localDataSourceHomeRepoImpl =
          LocalDataSourceHomeRepoImpl(database: db);

      when(
        () => db.query(
          'foodtype',
          where: 'inserted_at >= ?',
          whereArgs: any(named: 'whereArgs'),
        ),
      ).thenAnswer((_) async => []);
      final result = await localDataSourceHomeRepoImpl.fetchCategoryData();
      verify(
        () => db.query(
          'foodtype',
          where: 'inserted_at >= ?',
          whereArgs: any(named: 'whereArgs'),
        ),
      ).called(1);

      expect(result.isLeft(), true);
      expect(
        result.fold((l) => l.message, (_) => null),
        LocalDataBaseFailure("Cache expired or empty").message,
      );
    },
  );
  test(
    'Given a RemoteDataSourceHomeRepoImpl, when fetchCategoryData called then return a empty list of HomeCategoryModel',
    () async {
      final Dio dio = MockDio();
      final RemoteDataSourceHomeRepoImpl remoteDataSourceHomeRepoImpl =
          RemoteDataSourceHomeRepoImpl(dio: dio);

      when(() => dio.get(ApiEndpoints.foodType)).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: Map<String, dynamic>.from({}),
        ),
      );

      final result = await remoteDataSourceHomeRepoImpl.fetchCategoryData();

      verify(() => dio.get(ApiEndpoints.foodType)).called(1);

      expect(result.isRight(), true);
      expect(result.fold((_) => null, (s) => s.data), []);
    },
  );
  test(
    'Given a HomeCategoryUseCase , when fetchHomeCategories called, then it should return a empty list of home categories',
    () async {
      final HomeRepo mockHomeRepo = MockHomeRepo();
      final HomeCategoryUseCase useCase = HomeCategoryUseCase(
        homeRepo: mockHomeRepo,
      );

      when(
        () => mockHomeRepo.fetchCategoryData(),
      ).thenAnswer((_) async => Right(SuccessHandlerImpl([])));
      final result = await useCase.fetchHomeCategories();
      verify(() => mockHomeRepo.fetchCategoryData()).called(1);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => SuccessHandlerImpl([])).data, []);
    },
  );
}
