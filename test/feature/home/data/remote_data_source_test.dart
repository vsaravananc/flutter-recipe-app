import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe/feature/home/data/data_source/remote_data_source/remote_data_source_repo_impl.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late RemoteDataSourceHomeRepoImpl remoteDataSourceHomeRepoImpl;

  setUp(() {
    dio = MockDio();
    remoteDataSourceHomeRepoImpl = RemoteDataSourceHomeRepoImpl(dio: dio);
  });

  group('fetchCategoryData()', () {
    group('failer', () {
      test('Dio exception', () async {
        when(
          () => dio.get(any()),
        ).thenThrow(DioException(requestOptions: RequestOptions()));
        final result = await remoteDataSourceHomeRepoImpl.fetchCategoryData();
        verify(() => dio.get(any())).called(1);
        expect(result.isLeft(), isTrue);
        expect(
          result.fold((f) => f.message, (_) => null),
          "Couldn't reach the server. Please check your connection or try again later",
        );
      });
      test('Type Error', () async {
        when(() => dio.get(any())).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            requestOptions: RequestOptions(),
            data: {},
          ),
        );
        final result = await remoteDataSourceHomeRepoImpl.fetchCategoryData();
        verify(() => dio.get(any())).called(1);
        expect(result.isLeft(), isTrue);
        expect(
          result.fold((f) => f.message, (_) => null),
          "Unexpected data from server received. Please check your connection or try again later.",
        );
      });
      test('catch', () async {});
    });
    group('succes', () {
      test('return list of HomeCategoryModel', () async {});
    });
  });
}
