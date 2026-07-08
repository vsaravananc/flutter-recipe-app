import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
        test('description', () async {});
      });
      group('success', ()  {});
    });
    group('fetchRecipeData()', () {
      group('failure', ()  {});
      group('success', ()  {});
    });
  });
}
