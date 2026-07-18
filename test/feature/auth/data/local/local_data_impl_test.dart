import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe/core/services/beral_container.dart';
import 'package:recipe/feature/auth/data/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class MockDatabase extends Mock implements Database {}


void main() {
  test(
    'Given a LocalDataImpl, when a addUser called, then return nothing',
    () async {
      final mockUser = const UserModel(uid: '', email: '', name: '');
      final mockDatabase = MockDatabase();
      final mockLocalDataImpl = LocalDataImpl(database: mockDatabase);

      when(
        () => mockDatabase.insert(
          'user',
          mockUser.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).thenAnswer((_) async => 1);

      await mockLocalDataImpl.addUser(mockUser);

      verify(
        () => mockDatabase.insert(
          'user',
          mockUser.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).called(1);
    },
  );

  test(
    'Given a LocalDataImpl, when a addUser called, then throw dataException',
    () async {
      final mockUser = const UserModel(uid: '', email: '', name: '');
      final mockDatabase = MockDatabase();
      final mockLocalDataImpl = LocalDataImpl(database: mockDatabase);

      when(
        () => mockDatabase.insert(
          'user',
          mockUser.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).thenThrow(DatabaseException);

      expect(()=> mockLocalDataImpl.addUser(mockUser), throwsA(DatabaseException));
    },
  );
}
