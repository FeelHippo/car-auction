import 'package:carbids/data/network/dio/dio_logger.dart';
import 'package:carbids/data/network/interceptors/content_type_interceptor.dart';
import 'package:dio/dio.dart';

class DioFactory {
  static Dio create() {
    final BaseOptions options = BaseOptions(
      baseUrl: 'https://carapi.app/',
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (int? status) {
        return status != null;
      },
    );

    final Dio dio = Dio()..options = options;

    dio.interceptors.addAll(
        <Interceptor>[
          ContentTypeInterceptor(),
          DioLogger(
            requestBody: true,
            responseBody: true,
            requestHeader: true,
            compact: true,
          ),
        ]
    );

    return dio;
  }
}
