import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/home/data/data_source/data_source_repo_impl.dart';
import 'package:recipe/feature/home/data/data_source/local_data_source/local_data_source_repo.dart';
import 'package:recipe/feature/home/data/data_source/remote_data_source/remote_data_source_repo.dart';

class MockLocalDataSourceHomeRepo extends Mock
    implements LocalDataSourceHomeRepo {}

class MockRemoteDataSourceHomeRepo extends Mock
    implements RemoteDataSourceHomeRepo {}

void main() {
  late MockLocalDataSourceHomeRepo mockLocalDataSourceHomeRepo;
  late MockRemoteDataSourceHomeRepo mockRemoteDataSourceHomeRepo;
  late DataSourceHomeRepoImpl dataSourceHomeRepoImpl;

  setUp(() {
    mockLocalDataSourceHomeRepo = MockLocalDataSourceHomeRepo();
    mockRemoteDataSourceHomeRepo = MockRemoteDataSourceHomeRepo();
    dataSourceHomeRepoImpl = DataSourceHomeRepoImpl(
      localDataRepo: mockLocalDataSourceHomeRepo,
      remoteDataRepo: mockRemoteDataSourceHomeRepo,
    );
  });
  group('DataSourceHomeRepoImpl', () {
    group('fetchCategoryData()', () {
      group('failure', () {
        test('LocalDataResult and remoteDataResult has failed ', () async {
          when(
            () => mockLocalDataSourceHomeRepo.fetchCategoryData(),
          ).thenAnswer(
            (_) async => left(LocalDataBaseFailure("Cache expired or empty")),
          );
          when(
            () => mockRemoteDataSourceHomeRepo.fetchCategoryData(),
          ).thenAnswer(
            (_) async =>
                left(NotValideCodeFailer("Oops! Something went wrong.")),
          );

          final result = await dataSourceHomeRepoImpl.fetchCategoryData();

          verifyInOrder([
            () => mockLocalDataSourceHomeRepo.fetchCategoryData(),
            () => mockRemoteDataSourceHomeRepo.fetchCategoryData(),
          ]);

          verifyNever(() => mockLocalDataSourceHomeRepo.addCategoryData(any()));
          expect(result.isLeft(), isTrue);
        });
      });
      group('success', () {
        test('localDataResult have data', () async {
          when(
            () => mockLocalDataSourceHomeRepo.fetchCategoryData(),
          ).thenAnswer((_) async => Right(SuccessHandlerImpl([])));

          final result = await dataSourceHomeRepoImpl.fetchCategoryData();

          verify(
            () => mockLocalDataSourceHomeRepo.fetchCategoryData(),
          ).called(1);

          verifyNever(() => mockRemoteDataSourceHomeRepo.fetchCategoryData());
          verifyNever(() => mockLocalDataSourceHomeRepo.addCategoryData(any()));

          expect(result.isRight(), isTrue);
        });
        test(
          'localDataResult has failed but remoteDataResult have data',
          () async {
            when(
              () => mockLocalDataSourceHomeRepo.fetchCategoryData(),
            ).thenAnswer(
              (_) async => left(LocalDataBaseFailure("Cache expired or empty")),
            );

            when(
              () => mockRemoteDataSourceHomeRepo.fetchCategoryData(),
            ).thenAnswer((_) async => right(SuccessHandlerImpl([])));

            when(
              () => mockLocalDataSourceHomeRepo.addCategoryData(any()),
            ).thenAnswer((_) async {});

            final result = await dataSourceHomeRepoImpl.fetchCategoryData();

            verifyInOrder([
              () => mockLocalDataSourceHomeRepo.fetchCategoryData(),
              () => mockRemoteDataSourceHomeRepo.fetchCategoryData(),
            ]);
            verify(
              () => mockLocalDataSourceHomeRepo.addCategoryData(any()),
            ).called(1);
            expect(result.isRight(), isTrue);
          },
        );
      });
    });
    group('fetchRecipeData()', () {
      group('failure', ()  {});
      group('success', ()  {});
    });
  });
}
