import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe/core/api/endpoints/api_endpoints.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/core/services/beral_container.dart';
import 'package:recipe/feature/home/data/data_source/data_source_repo.dart';
import 'package:sqflite/sqflite.dart';

class MockHomeRepo extends Mock implements HomeRepo {}

/* DATA CALL MOCK */

class MockDataSourceHomeRepoImpl extends Mock implements DataSourceRepo {}

class MockLocalDataSourceHomeRepoImpl extends Mock
    implements LocalDataSourceHomeRepo {}

class MockRemoteDataSourceHomeRepoImpl extends Mock
    implements RemoteDataSourceHomeRepo {}

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

      expect(result.isLeft(), isTrue);
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
    'Given a DataSourceHomeRepoImpl, when fetchCategoryData is called, then it should return a empty list<HomeCategoryModel> from remote',
    () async {
      final mockLocalDataSourceHomeRepoImpl = MockLocalDataSourceHomeRepoImpl();

      final mockRemoteDataSourceHomeRepoImpl =
          MockRemoteDataSourceHomeRepoImpl();

      final dataSourceHomeRepoImpl = DataSourceHomeRepoImpl(
        localDataRepo: mockLocalDataSourceHomeRepoImpl,
        remoteDataRepo: mockRemoteDataSourceHomeRepoImpl,
      );
      when(
        () => mockLocalDataSourceHomeRepoImpl.fetchCategoryData(),
      ).thenAnswer(
        (_) async => Left(LocalDataBaseFailure("Cache expired or empty")),
      );
      when(
        () => mockRemoteDataSourceHomeRepoImpl.fetchCategoryData(),
      ).thenAnswer((_) async => Right(SuccessHandlerImpl([])));
      when(
        () => mockLocalDataSourceHomeRepoImpl.addCategoryData([]),
      ).thenAnswer((_) async {});
      final result = await dataSourceHomeRepoImpl.fetchCategoryData();
      verify(
        () => mockLocalDataSourceHomeRepoImpl.fetchCategoryData(),
      ).called(1);
      verify(
        () => mockRemoteDataSourceHomeRepoImpl.fetchCategoryData(),
      ).called(1);
      verify(
        () => mockLocalDataSourceHomeRepoImpl.addCategoryData([]),
      ).called(1);
      expect(result.isRight(), isTrue);
      expect(result.fold((_) => null, (s) => s.data), []);
    },
  );

  test(
    'Given a HomeRepoImpl class, when fetchCategoryData is called, then it should return a empty list of HomeCategoryEntities',
    () async {
      final mockDataSourceHomeRepoImpl = MockDataSourceHomeRepoImpl();
      final homeRepoImpl = HomeRepoImpl(
        dataSourceRepo: mockDataSourceHomeRepoImpl,
      );

      when(
        () => mockDataSourceHomeRepoImpl.fetchCategoryData(),
      ).thenAnswer((_) async => Right(SuccessHandlerImpl([])));

      final result = await homeRepoImpl.fetchCategoryData();

      verify(() => mockDataSourceHomeRepoImpl.fetchCategoryData()).called(1);
      expect(result.isRight(), isTrue);
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

      expect(result.isRight(), isTrue);
      expect(result.fold((_) => null, (s) => s.data), []);
    },
  );
}
