import 'package:dio/dio.dart';
import 'package:recipe/core/api/endpoints/api_endpoints.dart';

class DioClient {
  late Dio dio;
  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        sendTimeout: const Duration(seconds: 3),
      ),
    );
  }
  Dio get dioClient => dio;
}
