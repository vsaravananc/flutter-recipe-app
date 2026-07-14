import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe/core/api/endpoints/api_endpoints.dart';
import 'package:recipe/feature/home/data/data_source/remote_data_source/remote_data_source_repo_impl.dart';
import 'package:recipe/feature/home/data/model/home_category_model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late RemoteDataSourceHomeRepoImpl remoteDataSourceHomeRepoImpl;

  setUp(() {
    dio = MockDio();
    remoteDataSourceHomeRepoImpl = RemoteDataSourceHomeRepoImpl(dio: dio);
  });

  group('Given a RemoteDataSourceHomeRepoImpl', () {
    group('fetchCategoryData()', () {
      group('failer', () {
        test('not equal to 200', () async {
          when(() => dio.get(ApiEndpoints.foodType)).thenAnswer(
            (_) async => Response(
              statusCode: 422,
              requestOptions: RequestOptions(),
              data: {},
            ),
          );

          final result = await remoteDataSourceHomeRepoImpl.fetchCategoryData();

          verify(() => dio.get(ApiEndpoints.foodType)).called(1);
          expect(result.isLeft(), isTrue);
          expect(
            result.fold((f) => f.message, (_) => null),
            "Oops! Something went wrong.",
          );
        });
        test('Dio exception', () async {
          when(
            () => dio.get(ApiEndpoints.foodType),
          ).thenThrow(DioException(requestOptions: RequestOptions()));
          final result = await remoteDataSourceHomeRepoImpl.fetchCategoryData();
          verify(() => dio.get(ApiEndpoints.foodType)).called(1);
          expect(result.isLeft(), isTrue);
          expect(
            result.fold((f) => f.message, (_) => null),
            "Couldn't reach the server. Please check your connection or try again later",
          );
        });
        test('Type Error', () async {
          when(() => dio.get(ApiEndpoints.foodType)).thenAnswer(
            (_) async => Response(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: {},
            ),
          );
          final result = await remoteDataSourceHomeRepoImpl.fetchCategoryData();
          verify(() => dio.get(ApiEndpoints.foodType)).called(1);
          expect(result.isLeft(), isTrue);
          expect(
            result.fold((f) => f.message, (_) => null),
            "Unexpected data from server received. Please check your connection or try again later.",
          );
        });
        test('catch', () async {
          when(
            () => dio.get(ApiEndpoints.foodType),
          ).thenThrow(const FormatException('format expection'));

          final result = await remoteDataSourceHomeRepoImpl.fetchCategoryData();

          verify(() => dio.get(ApiEndpoints.foodType)).called(1);
          expect(result.isLeft(), isTrue);
          expect(
            result.fold((f) => f.message, (_) => null),
            "We’re unable to reach the server right now. Please check your connection or try again later.",
          );
        });
      });
      group('succes', () {
        test('return list of HomeCategoryModel', () async {
          when(() => dio.get(ApiEndpoints.foodType)).thenAnswer(
            (_) async => Response(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: {
                'categories': [
                  {
                    'idCategory': 'dummy',
                    'strCategory': 'dummy',
                    'strCategoryThumb': 'dummy',
                    'strCategoryDescription': 'dummy',
                  },
                ],
              },
            ),
          );

          final result = await remoteDataSourceHomeRepoImpl.fetchCategoryData();

          verify(() => dio.get(ApiEndpoints.foodType)).called(1);
          expect(result.isRight(), isTrue);
          expect(result.fold((_) => null, (r) => r.data), const [
            HomeCategoryModel(
              id: 'dummy',
              name: 'dummy',
              imageUrl: 'dummy',
              description: 'dummy',
            ),
          ]);
        });
      });
    });

    group('fetchRecipeData(?)', () {
      group('failer', () {
        test('not equal to 200', () async {
          when(() => dio.get(any())).thenAnswer(
            (_) async =>
                Response(requestOptions: RequestOptions(), statusCode: 400),
          );
          final result = await remoteDataSourceHomeRepoImpl.fetchRecipeData('');
          expect(result.isLeft(), isTrue);
          expect(
            result.fold((f) => f.message, (_) => null),
            'Oops! Something went wrong.',
          );
        });
        test('DioException', () async {
          when(
            () => dio.get(any()),
          ).thenThrow(DioException(requestOptions: RequestOptions()));
          final result = await remoteDataSourceHomeRepoImpl.fetchRecipeData('');
          verify(() => dio.get(any())).called(1);
          expect(result.isLeft(), isTrue);
          expect(
            result.fold((f) => f.message, (_) => null),
            "Couldn't reach the server. Please check your connection or try again later",
          );
        });
      });
      group('succes', () {});
    });

  });
}
