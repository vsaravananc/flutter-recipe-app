import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe/feature/home/data/data_source/local_data_source/local_data_source_repo_impl.dart';
import 'package:recipe/feature/home/data/model/home_category_model.dart';
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

  group('Given a LocalDataSourceHomeRepoImpl,'
      'When fetchCategoryData called,'
      'Then throw Exceptions', () {
    test('DatabaseException', () async {
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
    test('TypeError', () async {
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
  });

  group('Given a LocalDataSourceHomeRepoImpl,'
      'When fetchCategoryData called,'
      'Then return list of homecategorymodel', () {
    test('list of homecategorymodel', () async {
      when(
        () => database.query(
          'foodtype',
          where: 'inserted_at >= ?',
          whereArgs: any(named: 'whereArgs'),
        ),
      ).thenAnswer(
        (_) async => [
          {
            'id': 0,
            'strCategory': 'dummy',
            'strCategoryThumb': 'dummy',
            'strCategoryDescription': 'dummy',
          },
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

      expect(result.isRight(), isTrue);
      expect(result.fold((_) => null, (s) => s.data), [
        const HomeCategoryModel(
          id: '0',
          name: 'dummy',
          imageUrl: 'dummy',
          description: 'dummy',
        ),
      ]);
    });
  });

}
