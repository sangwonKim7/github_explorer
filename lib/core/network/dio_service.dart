import 'package:dio/dio.dart';
import 'package:github_explorer/core/network/urls.dart';
import 'package:github_explorer/core/utils/logger.dart';

class DioService {
  static final DioService _dioClient = DioService._internal();
  factory DioService() => _dioClient;

  static Dio _dio = Dio();

  DioService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Urls.base,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      sendTimeout: const Duration(milliseconds: 10000),
      // headers: {},
    );
    _dio = Dio(options);
    _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio => _dio;
}

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i(
      "BaseUrl: ${options.baseUrl}\n"
      "Path: ${options.path}\n"
      "Parameters: ${options.queryParameters}\n"
      "Uri: ${options.uri}\n"
      "Data: ${options.data}\n"
      "Connect Timeout: ${options.connectTimeout}\n"
      "Send Timeout: ${options.sendTimeout}\n"
      "Receive Timeout: ${options.receiveTimeout}",
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i("response statusCode: ${response.statusCode}");
    logger.i("response data: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(err, ErrorInterceptorHandler handler) async {
    logger.e("Error ${err.error}");
    logger.e("Error Message ${err.message}");
    super.onError(err, handler);
  }
}
