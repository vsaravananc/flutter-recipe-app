import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe/feature/home/data/data_source/local_data_source/local_data_source_repo_impl.dart';
import 'package:sqflite/sqlite_api.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  late MockDatabase database;
  late LocalDataSourceHomeRepoImpl localDatabSourceHomeRepoImpl;

  setUp(() {
    database = MockDatabase();
    localDatabSourceHomeRepoImpl = LocalDataSourceHomeRepoImpl(
      database: database,
    );
  });
  test('Given a LocalDataSourceHomeRepoImpl,'
      'When fetchCategoryData called,'
      'Then throw a DatabaseException', () async {
    when(
      () => database.query(
        'foodtype',
        where: 'inserted_at >= ?',
        whereArgs: any(named: 'whereArgs'),
      ),
    ).thenThrow(DatabaseException);

    final result = await localDatabSourceHomeRepoImpl.fetchCategoryData();

    verify(
      () => database.query(
        'foodtype',
        where: 'inserted_at >= ?',
        whereArgs: any(named: 'whereArgs'),
      ),
    ).called(1);

    expect(result.isLeft(), isTrue);
    expect(
      result.fold((f) => f.message, (_) => null),
      'Failed to fetch data from local source',
    );
  });
  test('Given a LocalDataSourceHomeRepoImpl,'
      'When fetchCategoryData called,'
      'Then throw a TypeError', () async {
    when(
      () => database.query(
        'foodtype',
        where: 'inserted_at >= ?',
        whereArgs: any(named: 'whereArgs'),
      ),
    ).thenAnswer(
      (_) async => [
        Map<String, Object>.from({'dummy': 'dummy'}),
      ],
    );

    final result = await localDatabSourceHomeRepoImpl.fetchCategoryData();

    verify(
      () => database.query(
        'foodtype',
        where: 'inserted_at >= ?',
        whereArgs: any(named: 'whereArgs'),
      ),
    ).called(1);

    expect(result.isLeft(), isTrue);
    expect(
      result.fold((f) => f.message, (_) => null),
      'Data format is incorrect',
    );
  });
}
