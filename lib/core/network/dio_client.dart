import 'package:dio/dio.dart';
import 'package:github_explorer/core/utils/logger.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.i('Request: ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i('Response: ${response.statusCode} ${response.requestOptions.uri}\nResponse Data: ${response.data}');
          return handler.next(response);
        },
        onError: (e, handler) {
          logger.e('Error: ${e.response?.statusCode} ${e.requestOptions.uri}', error: e);
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
